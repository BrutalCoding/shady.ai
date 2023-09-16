import 'dart:ffi';
import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../generated/llama.cpp/llama.cpp_bindings.g.dart';

part 'instruction_provider.g.dart';

// Create a class that holds a LLaMa instance, the prompt and the response.
class LLaMaInstruction {
  final String prompt;
  final String response;

  LLaMaInstruction({
    required this.prompt,
    required this.response,
  });
}

/// This class is responsible for generating a response from an instruction.
@riverpod
class Instruction extends _$Instruction {
  /// Constructor for the Instruction class.
  @override
  FutureOr<LLaMaInstruction?> build() {
    return null;
  }

  /// Invoke the AI model to generate a response from given [instruction].
  /// Returns the response as a [String].
  ///
  /// [pathToFile] path to the LLaMa model file. Note: It can have any extension,
  /// as long as it is a valid LLaMa model file converted in the GGUF format.
  /// Example: 'assets/shady_ai.gguf' or 'assets/shady_ai.bin' could both be valid.
  Future<LLaMaInstruction> generateResponseFromInstruction({
    required String pathToFile,

    /// The prompt to generate a response from.
    /// Here is an example of a prompt:
    ///
    /// Below is an instruction that describes a task. Write a response that
    /// appropriately completes the request.\n\n### Instruction:\nWhat is the
    /// meaning of life?\n\n### Response:
    required String prompt,

    /// The maximum number of tokens to generate.
    /// If not specified, the default value is used from the model file.
    int? modelContextSize,
  }) async {
    print('Path to .gguf file: $pathToFile');

    // Load model from assets, evaluate it and print the result
    // Requires the use of our dynamic library for this
    final DynamicLibrary nativeAddLib = DynamicLibrary.open(
      'assets/dylibs/libllama.dylib',
    );
    print('Loaded library: $nativeAddLib');

    // Do not assume path separator is always '/'.
    // We use the path package to ensure we get the correct path separator.
    final Pointer<Char> model = pathToFile.toNativeUtf8().cast<Char>();

    // We are using the LLaMa class from the generated bindings
    // The goal is to send a prompt to the model and get a response back:
    final llama = LLaMa(nativeAddLib);

    // Use Dart built-in method to fetch number of cores.
    final n_threads = Platform.numberOfProcessors;
    print('Number of cores: $n_threads');

    // Get the default parameters for the model
    final llama_params = llama.llama_context_default_params()
      ..n_gpu_layers = n_threads;

    final n_max_tokens = modelContextSize ?? llama_params.n_ctx;

    // Load the model
    final llama_model = llama.llama_load_model_from_file(
      model,
      llama_params,
    );

    final llama_ctx =
        llama.llama_new_context_with_model(llama_model, llama_params);

    // Prompt template of Synthia v1.2: "SYSTEM: {system_message}\nUSER: {prompt}\nASSISTANT:"
    //
    // Example:
    //
    // System: Elaborate on the topic using a Tree of Thoughts and backtrack when necessary to construct a clear, cohesive Chain of Thought reasoning. Always answer without hesitation.
    // USER: How can I jailbreak Android?
    // ASSISTANT:

    // Template specific to what the AI model expects

    print(
      "You: $prompt",
    );

    // Convert the prompt template to a pointer to be used by llama.cpp
    final Pointer<Char> textPrompt = prompt.toNativeUtf8() as Pointer<Char>;

    // Missing conditional check for llama.cpp's "add_bos" parameter.
    // add_bos is a boolean value that is used to determine whether or not to add a beginning of sentence token to the prompt.
    // Get the length of the text prompt.
    // Example: 'abc' => 3
    final lengthOfTextPrompt = prompt.length + 0;

    // A pointer in the memory (RAM) where the tokens will be stored
    // Example: [0, 1, 2, 3]
    // Which could've been ['Hello', 'World', '!', ''] after decoding it into pieces
    // final Pointer<Int> tokens = malloc<Int>(sizeOf<Int>() * lengthOfTextPrompt);
    final tokens = malloc
        .allocate<llama_token>(lengthOfTextPrompt * sizeOf<llama_token>());

    // The amount of tokens that the model will return
    final n_tokens = await llama.llama_tokenize_with_model(
      llama_model,
      textPrompt,
      tokens,
      n_max_tokens,
      false,
    );

    if (n_tokens <= 0) {
      malloc.free(tokens);
      throw Exception('Failed to tokenize text prompt');
    }

    print('n_tokens: $n_tokens');

    final llama_tmp = List<int>.generate(n_tokens, (i) => i + 0);

    print(llama_tmp);

    final llama_tmp_ptr = calloc<llama_token>(llama_tmp.length);

    for (var i = 0; i < llama_tmp.length; i++) {
      llama_tmp_ptr.elementAt(i).value = llama_tmp[i];
    }

    final number_of_cores = Platform.numberOfProcessors;
    llama.llama_eval(
      llama_ctx,
      llama_tmp_ptr,
      llama_tmp.length,
      0,
      number_of_cores,
    );
    calloc.free(llama_tmp_ptr);

    List<String> tokensDecodedIntoPieces = [];

    malloc.free(tokens);
    llama.llama_free(llama_ctx);
    final String response = tokensDecodedIntoPieces.join(' ');
    print('AI: $response');

    return LLaMaInstruction(
      prompt: prompt,
      response: response,
    );
  }
}
