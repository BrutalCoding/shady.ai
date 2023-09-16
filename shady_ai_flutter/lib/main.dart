import 'dart:ffi' hide Size;

import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:slick_slides/slick_slides.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:window_manager/window_manager.dart';

import 'data/prompt_config.dart';
import 'generated/llama.cpp/llama.cpp_bindings.g.dart';
import 'instruction/logic/instruction_provider.dart';
import 'instruction/widgets/drag_and_drop_widget.dart';
import 'slide_deck/slide_deck_page.dart';

/// The main entry point for any Dart app.
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by some plugins
  SlickSlides().initialize(); // For the slide deck
  await windowManager.ensureInitialized(); // For the window manager
  const minimumWindowSize = Size(1280, 800); // Current UI is not responsive

  // Set the window options. Important to keep the window size and minimum size the same.
  WindowOptions windowOptions = WindowOptions(
    minimumSize: minimumWindowSize,
    size: minimumWindowSize,

    // When [true], the window can't go fullscreen.
    skipTaskbar: false,

    // Hide the title bar for a cleaner look
    titleBarStyle: TitleBarStyle.hidden,
  );

  // Show the window to the foreground
  windowManager.waitUntilReadyToShow(windowOptions, () {
    windowManager.show();
  });

  // The first widget to be rendered in the app.
  runApp(
    const Main(),
  );
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'ShadyAI',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends HookConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  /// Basically, this converts the tokens to normal human readable text
  /// Example: [0, 1, 2, 3] => ['Hello', 'World', '!', '']
  static List<String> convertTokensToPieces(
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
        print(
          'Piece length: $pieceLength | Buffer: $buffer | Dart string: $dartString',
        );
        pieces.add(dartString);
      }

      // Free the allocated buffer.
      malloc.free(buffer);
    }

    return pieces;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final instructionNotifier = ref.watch(instructionProvider.notifier);
    final textTheme = Theme.of(context).textTheme;
    final filePath = useState<String>('');
    final promptTemplate = useState<PromptConfig>(PromptConfig.Synthia);
    final textControllerPromptSystem = useTextEditingController()
      ..text = promptTemplate.value.system ?? '';
    final textController = useTextEditingController();
    final stepperIndex = useState<int>(0);

    return Scaffold(
      appBar: AppBar(
        title: Text("ShadyAI"),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // Start pre-caching the image of the first slide
              // to avoid a sudden flash when opening the slide deck
              // (@BrutalCoding): User might not even open the slide deck. Any way to avoid this?
              precacheImage(
                const AssetImage('assets/background_beach.jpg'),
                context,
              );

              // Show the info dialog
              showDialog<void>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Info'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Created by Daniel Breedeveld (BrutalCoding).\n',
                        ),
                        const Text(
                          'Licensed under the AGPL 3.0 license.',
                        ),
                        const Text(
                          'This app is made with Flutter.',
                        ),
                        Divider(),
                        ListTile(
                          leading: const Icon(Icons.slideshow),
                          title: const Text(
                            'View slides about ShadyAI',
                          ),
                          onTap: () async {
                            await Future.wait([
                              windowManager.setFullScreen(true),
                              Future.delayed(
                                const Duration(seconds: 1),
                                () {},
                              ),
                            ]);
                            Navigator.of(context).pop();
                            await Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (context) => const SlideDeckPage(),
                              ),
                            );
                            await Future.delayed(
                              const Duration(seconds: 1),
                              () {},
                            );
                            await windowManager.setFullScreen(false);
                          },
                        ),
                        Divider(),
                        ListTile(
                          leading: const Icon(Icons.link),
                          title: const Text(
                            'ShadyAI on GitHub',
                          ),
                          subtitle: Text(
                            'Are you a developer? Check out the source code on GitHub.',
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
                            'AGPL 3.0 License',
                          ),
                          subtitle: Text(
                            'Read the license on GitHub.',
                          ),
                          onTap: () {
                            launchUrl(
                              Uri.parse(
                                'https://github.com/BrutalCoding/shady.ai/blob/main/LICENSE',
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
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/shady_app_icon.png',
                height: 150,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'Quick Start',
                        style: textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: filePath.value.isEmpty
                                ? "Please drag a compatible model into the box below."
                                : "Great, you have selected a ",
                          ),
                          if (filePath.value.isNotEmpty) ...[
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Tooltip(
                                message: "${p.basename(filePath.value)}",
                                child: Text(
                                  'model',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        decoration: TextDecoration.underline,
                                        decorationStyle:
                                            TextDecorationStyle.dotted,
                                      ),
                                ),
                              ),
                            ),
                            TextSpan(
                              text:
                                  ".\nYou may now follow the steps below to generate a response.",
                            ),
                          ],
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Builder(
                      builder: (context) {
                        if (filePath.value.isEmpty) {
                          return DragAndDropWidget(
                            onDrop: (path) {
                              filePath.value = path;
                            },
                          );
                        }

                        return Column(
                          children: [
                            Container(
                              width: 600,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Stepper(
                                    currentStep: stepperIndex.value,
                                    onStepContinue: () async {
                                      if (stepperIndex.value == 2) {
                                        if (textController.value.text.isEmpty) {
                                          await showDialog<void>(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog.adaptive(
                                                title: const Text('Try again'),
                                                content: const Text(
                                                  'You forgot to enter your prompt.',
                                                ),
                                              );
                                            },
                                          );
                                          return;
                                        }

                                        // Set the system prompt in the template
                                        promptTemplate.value =
                                            promptTemplate.value =
                                                promptTemplate.value.copyWith(
                                          defaultPromptFormat: promptTemplate
                                              .value.defaultPromptFormat,
                                          system: textControllerPromptSystem
                                              .value.text,
                                        );

                                        // Set the user prompt in the template
                                        promptTemplate.value =
                                            promptTemplate.value =
                                                promptTemplate.value.copyWith(
                                          user: textController.value.text,
                                        );

                                        // Show modal progress indicator
                                        showModalBottomSheet<void>(
                                          context: context,
                                          isDismissible: false,
                                          builder: (context) {
                                            return BottomSheet(
                                              onClosing: () {},
                                              showDragHandle: false,
                                              builder: (context) {
                                                return Container(
                                                  height: 400,
                                                  child: Center(
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            top: 16.0,
                                                          ),
                                                          child: Text(
                                                            'Generating response...',
                                                            style: Theme.of(
                                                              context,
                                                            )
                                                                .textTheme
                                                                .headlineLarge,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        const Text(
                                                          'This might take a while. Please wait.',
                                                        ),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        CircularProgressIndicator
                                                            .adaptive(),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        );

                                        // Allow the previous modal to be shown before generating the response.
                                        // Otherwise, the UI will freeze and the modal will not be shown on-time.
                                        await Future.delayed(
                                          const Duration(seconds: 3),
                                          () {},
                                        );

                                        // Generate the response from the AI
                                        try {
                                          final response =
                                              await instructionNotifier
                                                  .generateResponseFromInstruction(
                                            pathToFile: filePath.value,
                                            modelContextSize: promptTemplate
                                                .value.contextSize,
                                            prompt: promptTemplate
                                                .value.getCompletePrompt,
                                          );

                                          // Show response in a dialog
                                          await showDialog<void>(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog.adaptive(
                                                title: const Text(
                                                  'Response',
                                                ),
                                                content: Text(
                                                  response.response,
                                                ),
                                              );
                                            },
                                          );

                                          // Hide modal progress indicator
                                          Navigator.of(context).pop();
                                        } catch (e, s) {
                                          print(
                                            s,
                                          );
                                          // Hide modal progress indicator
                                          Navigator.of(context).pop();
                                          await Future.delayed(
                                            const Duration(seconds: 2),
                                            () {},
                                          );

                                          // Show error dialog
                                          await showDialog<void>(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog.adaptive(
                                                title: const Text(
                                                  'Error',
                                                ),
                                                actions: [
                                                  // Report issue (goes to GitHub)
                                                  TextButton(
                                                    onPressed: () {
                                                      final safeUriError =
                                                          Uri.encodeComponent(
                                                        e.toString(),
                                                      );
                                                      final safeUriStacktrace =
                                                          Uri.encodeComponent(
                                                        "# Steps to reproduce?\n1. Drag and drop the model\n2. Click on ...\n\n# Stacktrace\n\n```\n" +
                                                            s.toString(),
                                                      );
                                                      launchUrl(
                                                        Uri.parse(
                                                          'https://github.com/brutalcoding/shady.ai/issues/new?assignees=&labels=bug&template=bug_report.md&title=$safeUriError&body=$safeUriStacktrace',
                                                        ),
                                                      );
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text(
                                                      'Report issue',
                                                    ),
                                                  ),

                                                  // Close dialog
                                                  FilledButton(
                                                    onPressed: () {
                                                      Clipboard.setData(
                                                        ClipboardData(
                                                          text: s.toString(),
                                                        ),
                                                      );
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text(
                                                      'Close',
                                                    ),
                                                  ),
                                                ],
                                                content: Text(
                                                  'Crashed while generating response from instruction.\n\n$e',
                                                ),
                                              );
                                            },
                                          );
                                        } finally {}

                                        return;
                                      }

                                      stepperIndex.value++;
                                    },
                                    onStepCancel: () {
                                      if (stepperIndex.value == 0) return;
                                      stepperIndex.value--;
                                    },
                                    onStepTapped: (index) {
                                      stepperIndex.value = index;
                                    },
                                    steps: [
                                      Step(
                                        isActive: stepperIndex.value == 0,
                                        title: Text(
                                          'Select a template (optional)',
                                        ),
                                        subtitle: Text(
                                          'Usually, AI models expect a specific format for the prompt. You can select a template here to make sure that the AI understands your prompt.',
                                        ),
                                        content: Align(
                                          alignment: Alignment.centerLeft,
                                          child: DropdownMenu<PromptConfig>(
                                            onSelected: (template) {
                                              if (template == null) return;
                                              promptTemplate.value =
                                                  PromptConfig(
                                                defaultPromptFormat: '',
                                              );
                                            },
                                            dropdownMenuEntries: [
                                              DropdownMenuEntry(
                                                value: PromptConfig.Synthia,
                                                label: PromptConfig.Synthia
                                                    .toString(),
                                              ),
                                            ],
                                            initialSelection:
                                                promptTemplate.value,
                                          ),
                                        ),
                                      ),
                                      Step(
                                        isActive: stepperIndex.value == 1,
                                        title: Text(
                                          'Set a system message',
                                        ),
                                        subtitle: Text(
                                          'A system message allows you to give the AI some context in which it should respond. (recommended)',
                                        ),
                                        content: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            controller:
                                                textControllerPromptSystem,
                                            maxLines: 1,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'System message',
                                            ),
                                          ),
                                        ),
                                      ),
                                      Step(
                                        isActive: stepperIndex.value == 2,
                                        title: Text('Set your prompt'),
                                        subtitle: Text(
                                          'A user message is what you want to say to the AI. For example: ${promptTemplate.value.user}',
                                        ),
                                        content: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            controller: textController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Your prompt',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextButton(
                              child: const Text(
                                'I want to try another model',
                              ),
                              onPressed: () {
                                filePath.value = '';
                                stepperIndex.value = 0;
                                promptTemplate.value = PromptConfig.Synthia;
                                textController.clear();
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HowToGetStartedText extends StatelessWidget {
  const HowToGetStartedText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'To get started, drag a compatible model from your computer into the box below',
        ),
        // Info icon that explains what a compatible model is (any model that is a gguf file)
        IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () => showDialog<void>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Info'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'What is a compatible model?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'A compatible model is any model that is a gguf file.',
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'You can convert any LLaMa model to a gguf file using the LLaMa CLI.',
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'For more information, visit the LLaMa GitHub repository.',
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      leading: const Icon(Icons.link),
                      title: const Text(
                        'LLaMa on GitHub',
                      ),
                      subtitle: Text(
                        'Are you a developer? Check out the official documentation on GitHub.',
                      ),
                      onTap: () {
                        launchUrl(
                          Uri.parse(
                            'https://github.com/ggerganov/llama.cpp/tree/master/gguf-py',
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
    );
  }
}
