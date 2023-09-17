import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../router/router.dart';
import '../providers/instruction_response_provider.dart';

class InstructionInferencePage extends HookConsumerWidget {
  const InstructionInferencePage({
    required this.pathToFile,
    required this.promptTemplate,
    super.key,
  });

  final String pathToFile;
  final String promptTemplate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = InstructionResponseProvider(
      pathToFile: pathToFile,
      promptTemplate: promptTemplate,
    );
    final pod = ref.watch(
      provider,
    );
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            minWidth: 600,
            minHeight: 600,
            maxHeight: 720,
            maxWidth: 720,
          ),
          child: pod.when(
            data: (data) => Center(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Title
                          Text(
                            'Output',
                            style: Theme.of(
                              context,
                            ).textTheme.headlineLarge,
                          ),
                          // Body
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 16.0,
                            ),
                            child: Text(
                              data,
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Buttons
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          icon: Icon(
                            Icons.adaptive.arrow_back,
                          ),
                          onPressed: () {
                            HomePageRoute().go(context);
                          },
                          label: const Text(
                            'Back to previous page',
                          ),
                        ),
                        ElevatedButton.icon(
                          icon: Icon(
                            Icons.refresh,
                          ),
                          label: Text(
                            'Regenerate',
                          ),
                          onPressed: () {
                            ref.invalidate(provider);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            error: (error, stackTrace) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    'Error',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineLarge,
                  ),
                  // Body
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                    ),
                    child: Text(
                      "An error occured: $error",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        HomePageRoute().go(context);
                      },
                      child: const Text(
                        'Back',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            loading: () => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                    ),
                    child: Text(
                      'One moment please...',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineLarge,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const Text(
                    'This might take a while. Please wait.',
                  ),
                  const SizedBox(
                    height: 64,
                  ),
                  CircularProgressIndicator.adaptive(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
