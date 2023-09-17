import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:slick_slides/slick_slides.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:window_manager/window_manager.dart';

import 'data/prompt_template.dart';
import 'instruction/widgets/drag_and_drop_widget.dart';
import 'router/router.dart';
import 'slide_deck/slide_deck_page.dart';

/// The main entry point for any Dart app.
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by some plugins
  SlickSlides().initialize(); // For the slide deck
  await windowManager.ensureInitialized(); // For the window manager
  const minimumWindowSize = Size(1280, 960); // Current UI is not responsive

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

/// Global navigator key to access context from anywhere in the app.
final navigatorKey = GlobalKey<NavigatorState>();

/// [_router] is the global router for the app.
final _router = GoRouter(routes: $appRoutes);

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        title: 'ShadyAI',
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
      ),
    );
  }
}

class QuickStartPage extends HookConsumerWidget {
  const QuickStartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final instructionNotifier = ref.watch(instructionProvider.notifier);
    final textTheme = Theme.of(context).textTheme;
    final filePath = useState<String>('');
    final promptTemplate = useState<PromptTemplate>(
      PromptTemplate.defaultPromptTemplate(),
    );
    final textControllerPromptSystem = useTextEditingController()
      ..text = promptTemplate.value.systemMessage;
    final textController = useTextEditingController.fromValue(
      TextEditingValue(
        text: promptTemplate.value.prompt,
      ),
    );
    final stepperIndex = useState<int>(0);

    // If the template changes, update the text controller with the default prompt
    useEffect(
      () {
        textController.text = promptTemplate.value.prompt;
        return null;
      },
      [promptTemplate.value.promptTemplate],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("ShadyAI"),
        centerTitle: true,
        actions: [
          // Iconbutton to reset filepath etc
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              filePath.value = '';
              promptTemplate.value = PromptTemplate.defaultPromptTemplate();
              textControllerPromptSystem.text =
                  promptTemplate.value.systemMessage;
              textController.text = promptTemplate.value.prompt;
              stepperIndex.value = 0;
            },
          ),

          // Iconbutton to show info dialog
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
                    // TextButton to start with built-in model
                    if (filePath.value.isEmpty)
                      TextButton(
                        onPressed: () {
                          filePath.value = 'assets/shady.gguf';
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Best to be used with the following prompt template: ${PromptTemplate.story().label}',
                                ),
                              ),
                            );
                        },
                        child: const Text(
                          'I want to try out the built-in model',
                        ),
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
                                      if (stepperIndex.value < 3) {
                                        stepperIndex.value++;
                                        return;
                                      }
                                      if (stepperIndex.value == 3) {
                                        if (textController.value.text.isEmpty) {
                                          await showDialog<void>(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog.adaptive(
                                                title: const Text(
                                                  'Forgot something?',
                                                ),
                                                content: const Text(
                                                  'The prompt text is empty. Did you forget to write something?',
                                                ),
                                              );
                                            },
                                          );
                                          return;
                                        }

                                        // Set the system prompt in the template
                                        promptTemplate.value =
                                            promptTemplate.value.copyWith(
                                          promptTemplate: promptTemplate
                                              .value.promptTemplate,
                                          systemMessage:
                                              textControllerPromptSystem
                                                  .value.text,
                                        );

                                        // Set the user prompt in the template
                                        promptTemplate.value =
                                            promptTemplate.value.copyWith(
                                          prompt: textController.value.text,
                                        );

                                        // Navigate to the response page
                                        // with GoRouter (TypedRoute)
                                        InstructionInferencePageRoute(
                                          pathToFile: filePath.value,
                                          promptTemplate: jsonEncode(
                                            promptTemplate.value.toJson(),
                                          ),
                                        ).push<void>(context);
                                      }
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
                                          'Select a prompt template',
                                        ),
                                        subtitle: Text(
                                          'Usually, AI models expect a specific format for the prompt. This is known as a prompt template. You can select a prompt template from the dropdown below.',
                                        ),
                                        content: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              DropdownMenu<PromptTemplate>(
                                                onSelected: (template) {
                                                  if (template == null) return;
                                                  promptTemplate.value =
                                                      template;
                                                },
                                                dropdownMenuEntries:
                                                    PromptTemplate.all
                                                        .map(
                                                          (template) =>
                                                              DropdownMenuEntry(
                                                            value: template,
                                                            label:
                                                                template.label,
                                                          ),
                                                        )
                                                        .toList(),
                                                initialSelection:
                                                    promptTemplate.value,
                                                enableSearch: false,
                                                enableFilter: false,
                                                leadingIcon: Tooltip(
                                                  message: promptTemplate
                                                      .value.promptTemplate,
                                                  child: Icon(Icons.preview),
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 8,
                                                  ),
                                                ),
                                                controller:
                                                    TextEditingController
                                                        .fromValue(
                                                  TextEditingValue(
                                                    text: promptTemplate
                                                        .value.label,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Step(
                                        isActive: stepperIndex.value == 1,
                                        title: Text(
                                          'Set a system message' +
                                              (promptTemplate.value
                                                      .systemMessage.isNotEmpty
                                                  ? ''
                                                  : ' (not required)'),
                                        ),
                                        subtitle: Text(
                                          'A system message allows you to give the AI some context in which it should respond.',
                                        ),
                                        content: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            controller:
                                                textControllerPromptSystem,
                                            enabled: promptTemplate
                                                .value.systemMessage.isNotEmpty,
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
                                          'A user message is what you want to say to the AI.',
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

                                      // Step for context size
                                      Step(
                                        isActive: stepperIndex.value == 3,
                                        title: Text(
                                          'Set the maximum content length',
                                        ),
                                        subtitle: Text(
                                          'The content length is commonly known as context size. It is the maximum number of words / tokens that the AI will use to generate a response.',
                                        ),
                                        content: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            controller:
                                                TextEditingController.fromValue(
                                              TextEditingValue(
                                                text: promptTemplate
                                                    .value.contextSize
                                                    .toString(),
                                              ),
                                            ),
                                            maxLines: 1,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Context size',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
