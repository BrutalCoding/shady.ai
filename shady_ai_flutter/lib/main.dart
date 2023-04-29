import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shady_ai/themes/m3_dark_theme.dart';
import 'package:shady_ai/themes/m3_light_theme.dart';

import 'common/widgets/home_grid_widget.dart';

// Define a global key for the ScaffoldMessenger. Can be used to show snackbars.
final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() {
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
    final selectedTab = useState(0);

    // Define the children to display within the body at different breakpoints.
    final List<Widget> children = <Widget>[
      HomeGridWidget(
        text: 'Chat',
        onPressed: () {
          Navigator.pushNamed(context, '/chat');
        },
      ),
      const HomeGridWidget(
        text: 'Translate',
      ),
      const HomeGridWidget(
        text: 'Transcribe',
      ),
      const HomeGridWidget(
        text: 'Sing',
      ),
      const HomeGridWidget(
        text: 'Grammar',
      ),
      const HomeGridWidget(
        text: 'Summarize',
      ),
      const HomeGridWidget(
        text: 'Code',
      ),
    ];

    return MaterialApp(
      theme: m3LightTheme,
      darkTheme: m3DarkTheme,
      debugShowCheckedModeBanner: false,
      home: ScaffoldMessenger(
        key: scaffoldMessengerKey,
        child: AdaptiveScaffold(
          // An option to override the default breakpoints used for small, medium,
          // and large.
          smallBreakpoint: const WidthPlatformBreakpoint(end: 700),
          mediumBreakpoint:
              const WidthPlatformBreakpoint(begin: 700, end: 1000),
          largeBreakpoint: const WidthPlatformBreakpoint(begin: 1000),
          useDrawer: false,
          selectedIndex: selectedTab.value,
          onSelectedIndexChange: (int index) {
            scaffoldMessengerKey.currentState?.clearSnackBars();
            selectedTab.value = index;
            if (index > 0) {
              // Tell the user that this feature is not yet available.
              scaffoldMessengerKey.currentState?.showSnackBar(
                const SnackBar(
                  content: Text('This page is not yet available.'),
                ),
              );
            }
          },
          destinations: const <NavigationDestination>[
            NavigationDestination(
              icon: Icon(Icons.rocket_launch_outlined),
              selectedIcon: Icon(Icons.rocket_launch),
              label: 'Launchpad',
            ),
            NavigationDestination(
              icon: Icon(Icons.web),
              selectedIcon: Icon(Icons.chat),
              label: 'Feedback',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          body: (_) => GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.all(16),
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: children,
          ),
          smallBody: (_) => ListView.builder(
            itemCount: children.length,
            itemBuilder: (_, int idx) => children[idx],
          ),
          // Define a default secondaryBody.
          secondaryBody: (_) =>
              Image.asset('assets/images/dad_cutout.png', fit: BoxFit.cover),
          // Override the default secondaryBody during the smallBreakpoint to be
          // empty. Must use AdaptiveScaffold.emptyBuilder to ensure it is properly
          // overridden.
          smallSecondaryBody: AdaptiveScaffold.emptyBuilder,
        ),
      ),
    );
  }
}
