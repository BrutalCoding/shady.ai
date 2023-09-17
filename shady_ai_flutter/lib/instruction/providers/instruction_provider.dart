import 'dart:ffi';
import 'dart:ffi' as ffi;
import 'dart:io';
import 'dart:math';

import 'package:ffi/ffi.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/prompt_template.dart';
import '../../generated/llama.cpp/llama.cpp_bindings.g.dart';

part 'instruction_provider.g.dart';

/// Used to post process the response of the AI.
///
/// Example before: "USER: Hello, how are you?\nASSISTANT: I'm fine, thanks."
///
/// Example after:  "I'm fine, thanks."
typedef String OutputPostProcess(String output);

/// This class is responsible for generating a response from an instruction.
@riverpod
class InstructionInference extends _$InstructionInference {
  /// Constructor for the Instruction class.
  @override
  FutureOr<String> build() {
    return '';
  }

  ffi.Pointer<ffi.Int8> allocateCharArray(int length) {
    return calloc<ffi.Int8>(length);
  }

  ffi.Pointer<llama_token> allocateCIntList(int length) {
    return calloc<llama_token>(length);
  }

  int getStringLength(Pointer<Char> buffer) {
    int length = 0;
    while (buffer.elementAt(length).value != 0) {
      length++;
    }
    return length;
  }

  ffi.Pointer<ffi.Int> truncateMemory(
    ffi.Pointer<ffi.Int> original,
    int originalLength,
    int nOfTok,
  ) {
    // Step 1: Allocate a new block of memory of size n_of_tok
    final truncated = calloc<ffi.Int>(nOfTok);

    // Step 2: Copy data from the original pointer to the new pointer
    for (int i = 0; i < nOfTok && i < nOfTok; i++) {
      truncated[i] = original[i];
    }

    calloc.free(original);

    return truncated;
  }

  ffi.Pointer<ffi.Int> allocateIntArray(List<int> list) {
    final pointer = calloc<ffi.Int>(list.length);

    for (var i = 0; i < list.length; i++) {
      pointer[i] = list[i];
    }
    return pointer;
  }

  /// Invoke the AI model to generate a response from given [instruction].
  /// Returns the response as a [String].
  ///
  /// [pathToFile] path to the LLaMa model file. Note: It can have any extension,
  /// as long as it is a valid LLaMa model file converted in the GGUF format.
  /// Example: 'assets/shady_ai.gguf' or 'assets/shady_ai.bin' could both be valid.
  Future<String> generateResponseFromInstruction({
    required String pathToFile,

    /// The prompt to generate a response from.
    /// Here is an example of a prompt:
    ///
    /// Below is an instruction that describes a task. Write a response that
    /// appropriately completes the request.\n\n### Instruction:\nWhat is the
    /// meaning of life?\n\n### Response:
    required PromptTemplate promptTemplate,

    /// A method that takes in the output of the model and returns a response.
    /// Useful to filter out unwanted content.
    /// E.g. to only keep the part of the AI's response that answers the question.
    OutputPostProcess? outputPostProcess,
  }) async {
    final DynamicLibrary dylib = DynamicLibrary.open(
      'assets/dylibs/libllama.dylib',
    );
    final LLaMa llama_cpp = LLaMa(dylib);
    final lparams = llama_cpp.llama_context_default_params();
    final Pointer<Char> model_path = pathToFile.toNativeUtf8().cast<Char>();

    final model = llama_cpp.llama_load_model_from_file(
      model_path,
      lparams,
    );

    final N_THREADS = Platform.numberOfProcessors;

    String _prompt = promptTemplate.prompt;

    final Pointer<Char> prompt = _prompt.toNativeUtf8() as Pointer<Char>;

    final ctx = llama_cpp.llama_new_context_with_model(model, lparams);

    final tmp = [0, 1, 2, 3];

    // Here we're creating a list of length 4 and putting the items of tmp in it.
    final tmpPointer = allocateIntArray(tmp); //correct
    llama_cpp.llama_eval(ctx, tmpPointer, tmp.length, 0, N_THREADS);

    var n_past = 0;

    var embd_inp = calloc<llama_token>(_prompt.length + 1);
    final int n_max_tokens = _prompt.length + 1;
    final n_of_tok = llama_cpp.llama_tokenize(
      ctx,
      prompt,
      n_max_tokens,
      embd_inp,
      n_max_tokens,
      true,
    );

    embd_inp = truncateMemory(embd_inp, n_of_tok, n_of_tok);
    final n_ctx = llama_cpp.llama_n_ctx(ctx);

    var n_predict = 20;
    n_predict = min(n_predict, n_ctx - n_of_tok);

    var input_consumed = 0;
    var input_noecho = false;

    int remaining_tokens = n_predict;

    var embd = <int>[];
    final last_n_size = 64;
    var last_n_tokens_data = List.generate(last_n_size, (index) => 0);
    final n_batch = 24;
    final last_n_repeat = 64;
    final repeat_penalty = 1.0;
    final frequency_penalty = 0.0;
    final presence_penalty = 0.0;

    List<String> tokensDecodedIntoPieces = [];

    while (remaining_tokens > 0) {
      if (embd.length > 0) {
        final embdPointer = allocateIntArray(embd);
        llama_cpp.llama_eval(ctx, embdPointer, embd.length, n_past, N_THREADS);
        calloc.free(embdPointer); // Freeing the pointer after using it
      }

      n_past += embd.length;
      embd = [];

      if (n_of_tok <= input_consumed) {
        final logits = llama_cpp.llama_get_logits(ctx);
        final n_vocab = llama_cpp.llama_n_vocab(ctx);

        final _arr = calloc<llama_token_data>(n_vocab);

        for (var token_id = 0; token_id < n_vocab; token_id++) {
          _arr[token_id].id = token_id;
          _arr[token_id].logit = logits[token_id];
          _arr[token_id].p = 0.0;
        }

        // 1. Allocate memory for the struct
        final candidates_p = calloc<llama_token_data_array>();

        // 2. Assign values to its fields
        candidates_p.ref.data = _arr;
        candidates_p.ref.size = n_vocab;
        candidates_p.ref.sorted = false;

        final allocatedArray = allocateIntArray(last_n_tokens_data);
        llama_cpp.llama_sample_repetition_penalty(
          ctx,
          candidates_p,
          allocatedArray,
          last_n_repeat,
          repeat_penalty,
        );

        llama_cpp.llama_sample_frequency_and_presence_penalties(
          ctx,
          candidates_p,
          allocatedArray,
          last_n_repeat,
          frequency_penalty,
          presence_penalty,
        );

        llama_cpp.llama_sample_top_k(ctx, candidates_p, 40, 1);
        llama_cpp.llama_sample_top_p(ctx, candidates_p, 0.8, 1);
        llama_cpp.llama_sample_temperature(ctx, candidates_p, 0.2);
        final id = llama_cpp.llama_sample_token(ctx, candidates_p);

        // Shifting the list and appending the new id
        last_n_tokens_data = [...last_n_tokens_data.sublist(1), id];

        embd.add(id);
        input_noecho = false;
        remaining_tokens -= 1;
      } else {
        while (n_of_tok > input_consumed) {
          embd.add(embd_inp[input_consumed]);

          last_n_tokens_data.removeAt(0);
          last_n_tokens_data.add(embd_inp[input_consumed]);
          input_consumed++;
          if (embd.length >= n_batch) {
            break;
          }
        }
      }

      if (!input_noecho) {
        for (var id in embd) {
          final int size = 32;
          final Pointer<Char> buffer = calloc<Char>(size);

          final n = llama_cpp.llama_token_to_piece_with_model(
            model,
            id,
            buffer,
            size,
          );

          if (n <= 32) {
            final truncated = calloc<ffi.Char>(n);
            final length = getStringLength(buffer);
            for (int i = 0; i < n && i < length + 1; i++) {
              truncated[i] = buffer[i];
            }

            calloc.free(buffer);
            final dartString = truncated.cast<Utf8>().toDartString();
            tokensDecodedIntoPieces.add(dartString);
          }
        }
      }
      if (embd.length > 0 && embd.last == llama_cpp.llama_token_eos(ctx)) {
        break;
      }
    }

    final output = tokensDecodedIntoPieces.join('');

    return outputPostProcess?.call(output) ?? output;
  }
}
