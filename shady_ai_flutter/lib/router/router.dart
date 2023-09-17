import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../instruction/views/instruction_inference_page.dart';
import '../main.dart';

part 'router.g.dart';

@TypedGoRoute<HomePageRoute>(
  path: '/',
  routes: [
    TypedGoRoute<InstructionInferencePageRoute>(
      path: 'instruction-inference',
    ),
  ],
)
class HomePageRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const QuickStartPage();
  }
}

class InstructionInferencePageRoute extends GoRouteData {
  final String pathToFile;
  final String promptTemplate;

  const InstructionInferencePageRoute({
    required this.pathToFile,
    required this.promptTemplate,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return InstructionInferencePage(
      pathToFile: pathToFile,
      promptTemplate: promptTemplate,
    );
  }
}
