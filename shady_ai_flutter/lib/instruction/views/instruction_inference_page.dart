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
    // Get args from route
    final pod = ref.watch(
      InstructionResponseProvider(
        pathToFile: pathToFile,
        promptTemplate: promptTemplate,
      ),
    );
    return Scaffold(
      body: Center(
        child: Container(
          height: 600,
          width: 600,
          child: pod.when(
            data: (data) => Center(
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
                    // Close button
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 16.0,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          HomePageRoute().go(context);
                        },
                        child: const Text(
                          'Back to home',
                        ),
                      ),
                    ),
                  ],
                ),
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
                        'Back to home',
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
