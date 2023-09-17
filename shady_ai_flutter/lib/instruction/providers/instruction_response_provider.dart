import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/prompt_template.dart';
import '../../main.dart';
import 'instruction_provider.dart';

part 'instruction_response_provider.g.dart';

@riverpod
class InstructionResponse extends _$InstructionResponse {
  @override
  FutureOr<String> build({
    required String pathToFile,
    required String promptTemplate,
  }) async {
    final PromptTemplate _promptTemplate = PromptTemplate.fromJson(
      jsonDecode(
        promptTemplate,
      ) as Map<String, dynamic>,
    );
    final instructionNotifier =
        ref.watch(instructionInferenceProvider.notifier);
    // Generate the response from the AI
    try {
      state = AsyncValue.loading();
      await Future<void>.delayed(
        const Duration(
          seconds: 3,
        ),
      );
      final String response =
          await instructionNotifier.generateResponseFromInstruction(
        pathToFile: pathToFile,
        promptTemplate: _promptTemplate,
      );
      state = AsyncValue.data(response);
      return response;
    } catch (e, s) {
      print(
        s,
      );

      // Show error dialog
      final BuildContext? context = navigatorKey.currentContext;
      if (context != null)
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
                    final safeUriError = Uri.encodeComponent(
                      e.toString(),
                    );
                    final safeUriStacktrace = Uri.encodeComponent(
                      "# Steps to reproduce?\n1. Drag and drop the model\n2. Click on ...\n\n# Stacktrace\n\n```\n" +
                          s.toString(),
                    );
                    launchUrl(
                      Uri.parse(
                        'https://github.com/brutalcoding/shady.ai/issues/new?assignees=&labels=bug&template=bug_report.md&title=$safeUriError&body=$safeUriStacktrace',
                      ),
                    );
                    Navigator.of(context).pop();
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
                    Navigator.of(context).pop();
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

      rethrow;
    }
  }
}
