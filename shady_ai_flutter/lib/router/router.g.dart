// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $homePageRoute,
    ];

RouteBase get $homePageRoute => GoRouteData.$route(
      path: '/',
      factory: $HomePageRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'instruction-inference',
          factory: $InstructionInferencePageRouteExtension._fromState,
        ),
      ],
    );

extension $HomePageRouteExtension on HomePageRoute {
  static HomePageRoute _fromState(GoRouterState state) => HomePageRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $InstructionInferencePageRouteExtension
    on InstructionInferencePageRoute {
  static InstructionInferencePageRoute _fromState(GoRouterState state) =>
      InstructionInferencePageRoute(
        pathToFile: state.uri.queryParameters['path-to-file']!,
        promptTemplate: state.uri.queryParameters['prompt-template']!,
      );

  String get location => GoRouteData.$location(
        '/instruction-inference',
        queryParams: {
          'path-to-file': pathToFile,
          'prompt-template': promptTemplate,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
