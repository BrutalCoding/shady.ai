import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shady_ai/main.dart';

import '../widgets/home_grid_widget.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String routeName = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = useState(0);
    // Define the children to display within the body at different breakpoints.
    final List<Widget> children = <Widget>[
      HomeGridWidget(
        text: 'Chat',
        onPressed: () {},
      ),
      const HomeGridWidget(
        text: 'Translate',
      ),
      const HomeGridWidget(
        text: 'Transcribe',
      ),
      const HomeGridWidget(
        text: 'Music',
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
    return AdaptiveScaffold(
      // An option to override the default breakpoints used for small, medium,
      // and large.
      smallBreakpoint: const WidthPlatformBreakpoint(end: 700),
      mediumBreakpoint: const WidthPlatformBreakpoint(begin: 700, end: 1000),
      largeBreakpoint: const WidthPlatformBreakpoint(begin: 1000),
      useDrawer: false,
      selectedIndex: selectedTab.value,
      leadingExtendedNavRail: const SizedBox(
        height: 8,
      ),

      leadingUnextendedNavRail: const SizedBox(
        height: 8,
      ),

      onSelectedIndexChange: (int index) {
        // Clear any snackbars for that instant feedback feel.
        rootScaffoldMessengerKey.currentState?.clearSnackBars();

        // Only allow the first tab to be selected.
        if (index > 0) {
          rootScaffoldMessengerKey.currentState?.showSnackBar(
            const SnackBar(
              content: Text('This page is not yet available.'),
            ),
          );
          return;
        }
        // Otherwise, update the selected tab.
        selectedTab.value = index;
      },
      destinations: const <NavigationDestination>[
        NavigationDestination(
          icon: Icon(Icons.rocket_launch_outlined),
          selectedIcon: Icon(Icons.rocket_launch),
          label: 'AI Suite',
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
      body: (_) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Text(
              'Hey, Shady!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          Flexible(
            flex: 1,
            child: Text(
              "Let's get you started.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          Expanded(
              flex: 4,
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                padding: const EdgeInsets.all(16),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: children,
              ))
        ],
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
    );
  }
}
