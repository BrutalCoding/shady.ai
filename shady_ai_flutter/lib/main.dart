import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shady_ai/routing/router.dart';
import 'package:shady_ai/themes/m3_dark_theme.dart';
import 'package:shady_ai/themes/m3_light_theme.dart';
import 'package:window_manager/window_manager.dart';

// Define a global key for the ScaffoldMessenger. Can be used to show snackbars.
final rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    size: Size(1228, 944),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    title: 'ShadyAI',
    titleBarStyle: TitleBarStyle.hidden,
    minimumSize: Size(944, 660),
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(
    const ProviderScope(
      child: Main(),
    ),
  );
}

class Main extends HookConsumerWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      theme: m3LightTheme,
      darkTheme: m3DarkTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
