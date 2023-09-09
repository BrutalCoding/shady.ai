import 'dart:ffi';

import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import 'generated/llama.cpp/llama.cpp_bindings.g.dart';

void main() {
  runApp(const Main());
}

/// Main entry point for the app
class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShadyAI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends HookConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  /// Basically, this converts the tokens to normal human readable text
  /// Example: [0, 1, 2, 3] => ['Hello', 'World', '!', '']
  List<String> convertTokensToPieces(
    LLaMa llama,
    Pointer<llama_model> model,
    Pointer<Int> tokens,
    int tokenCount,
  ) {
    const int MAX_PIECE_SIZE =
        256; // You may adjust this size based on the expected length of each piece.
    List<String> pieces = [];

    for (int i = 0; i < tokenCount; i++) {
      Pointer<Char> buffer = malloc.allocate<Char>(MAX_PIECE_SIZE);

      int pieceLength = llama.llama_token_to_piece_with_model(
        model,
        tokens.elementAt(i).value, // Get the i-th token value.
        buffer,
        MAX_PIECE_SIZE,
      );

      // If a valid piece was returned (i.e., length > 0), convert it to a Dart string and add to the list.
      if (pieceLength > 0) {
        final dartString = buffer.cast<Utf8>().toDartString();
        print('Piece found: $dartString');
        pieces.add(buffer.cast<Utf8>().toDartString());
      } else {
        print('No piece found.');
      }

      // Free the allocated buffer.
      malloc.free(buffer);
    }

    return pieces;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final pathToShadyAI = useState<String?>(null);

    return Scaffold(
      appBar: AppBar(
        title: Text("ShadyAI"),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => showDialog<void>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Daniel Breedeveld'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SelectableText(
                          'ShadyAI is founded by Daniel Breedeveld (aka BrutalCoding)\n\n'
                          'I am a dreamer. A mind that is always thinking.\nI am a developer. A mind that is always creating.\n\n'
                          'I am a father. A mind that is always loving.\nI am a son. A mind that is always learning.'),
                      const SizedBox(height: 8),
                      ListTile(
                        leading: const Icon(Icons.link),
                        title: const Text(
                          'ShadyAI on GitHub',
                        ),
                        onTap: () {
                          launchUrl(
                            Uri.parse(
                              'https://github.com/BrutalCoding/shady.ai',
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.link),
                        title: const Text(
                          'Follow me on Twitter',
                        ),
                        onTap: () {
                          launchUrl(
                            Uri.parse(
                              'https://twitter.com/BrutalCoding',
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.link),
                        title: const Text(
                          'Follow me on LinkedIn',
                        ),
                        onTap: () {
                          launchUrl(
                            Uri.parse(
                              'https://linkedin.com/in/breedeveld/',
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/dad_the_benchmark.png',
                  width: 200,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            'Dad',
                            style: textTheme.headlineLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          "Dad is a model that is trained on a dataset of 1.5 million dad jokes.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Almost had you there. It doesn't exist (yet).",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        DragAndDropWidget(
                          onDrop: (String filePath) async {
                            pathToShadyAI.value = filePath;
                            onStart(context, pathToShadyAI.value!);
                          },
                        ),
                        Text('or'),
                        ElevatedButton(
                          onPressed: () {
                            onStart(context, pathToShadyAI.value!);
                          },
                          child: const Text('Force Start'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// This will run the inference on the model.
  void onStart(BuildContext context, String pathToShadyAI) async {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            'Running $pathToShadyAI...',
          ),
        ),
      );

    print(pathToShadyAI);

    // Load model from assets, evaluate it and print the result
    // Requires the use of our dynamic library for this
    final DynamicLibrary nativeAddLib = DynamicLibrary.open(
      'assets/dylibs/libllama.dylib',
    );

    // // Write the model to the documents directory
    // final Directory appDocumentsDir =
    //     await getApplicationDocumentsDirectory();

    // // Path to the model 'shady.ai' in the documents directory
    // final String pathToShadyAI = path_package.join(
    //   appDocumentsDir.path,
    //   'shady.ai',
    // );

    // // If the file 'shady.ai' doesn't exist in the documents folder of their OS
    // // then we abort the process and show a message to the user.
    // if (File(pathToShadyAI).existsSync() == false) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text(
    //         'File not found. Did you forget to drag and drop the AI model file?',
    //       ),
    //     ),
    //   );
    //   return;
    // }

    // Do not assume path separator is always '/'.
    // We use the path package to ensure we get the correct path separator.
    final Pointer<Char> model = pathToShadyAI.toNativeUtf8().cast<Char>();

    // We are using the LLaMa class from the generated bindings
    // The goal is to send a prompt to the model and get a response back:
    final llama = LLaMa(nativeAddLib);

    // Load the model
    final llama_model = await llama.llama_load_model_from_file(
      model,
      llama.llama_context_default_params(),
    );

    // // Input from the user:
    // final String humanInput =
    //     "Explain why sponsoring open source projects is important.";

    // Template specific to what the AI model expects
    final String promptTemplate = "What is the meaning of life?";

    print(
      "Prompt given by human: '$promptTemplate",
    );

    // Convert the prompt template to a pointer to be used by llama.cpp
    final Pointer<Char> textPrompt =
        promptTemplate.toNativeUtf8() as Pointer<Char>;

    // TODO: Add missing conditional check for llama.cpp's "add_bos" parameter.
    // add_bos is a boolean value that is used to determine whether or not to add a beginning of sentence token to the prompt.

    // Get the length of the text prompt.
    // Example: 'abc' => 3
    var lengthOfTextPrompt = promptTemplate.length + 0;

    // A pointer in the memory (RAM) where the tokens will be stored
    // Example: [0, 1, 2, 3]
    // Which could've been ['Hello', 'World', '!', ''] after decoding it into pieces
    // final Pointer<Int> tokens = malloc<Int>(sizeOf<Int>() * lengthOfTextPrompt);
    final tokens = malloc
        .allocate<llama_token>(lengthOfTextPrompt * sizeOf<llama_token>());

    // TODO: Replace hard-coded value with a dynamic value
    // The maximum amount of tokens that the model can return
    final int n_max_tokens = 2048;

    // The amount of tokens that the model will return
    final n_tokens = await llama.llama_tokenize_with_model(
      llama_model,
      textPrompt,
      tokens,
      n_max_tokens,
      true,
    );

    if (n_tokens <= 0) {
      malloc.free(tokens);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Error while running inference on the AI model.',
          ),
        ),
      );
      return;
    }

    print('n_tokens: $n_tokens');

    // A list of strings that are the decoded tokens
    final List<String> decodedIntoPieces = convertTokensToPieces(
      llama,
      llama_model,
      tokens,
      n_tokens,
    );

    // Join the pieces together into a single string
    // Example: ['Hello', 'World', '!', ''] => 'Hello World!'
    final String response = decodedIntoPieces.join(' ');

    // Print the decoded tokens
    print('Response by AI: $response');

    // Dialog pop up
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: const Text('AI Response'),
          content: SelectableText(response),
        );
      },
    );

    malloc.free(tokens);
  }
}

class DragAndDropWidget extends HookConsumerWidget {
  const DragAndDropWidget({super.key, required this.onDrop});

  final void Function(String pathToShadyAI) onDrop;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final xFileOfAiModel = useState<XFile?>(null);
    return DropTarget(
      onDragDone: (detail) async {
        xFileOfAiModel.value = detail.files.first;
        onDrop(xFileOfAiModel.value!.path);
      },
      child: Container(
        height: 100,
        width: 200,
        // rounded corners
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              "Drag and Drop your AI model into here",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
