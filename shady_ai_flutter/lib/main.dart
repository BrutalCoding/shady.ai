import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShadyAI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'ShadyAI'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // Display a dialog with information about the app.
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('About ShadyAI'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'ShadyAI is a project by BrutalCoding.'
                          "A collection of cutting edge AI tech that run locally on your device. "
                          "It's a work in progress, so don't expect too much yet.",
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
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/dad_the_benchmark.png',
                  width: 200,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Coming Soon',
                    style: textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 500,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Sorry, there is nothing to see yet. Watch my progress on GitHub.",
                          style: textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showMaterialBanner(
                      MaterialBanner(
                        content: const Text('Bringing you to ShadyAI...'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentMaterialBanner();
                            },
                            child: const Text('Dismiss'),
                          ),
                        ],
                      ),
                    );
                    launchUrl(
                      Uri.parse('https://github.com/BrutalCoding/shady.ai'),
                    );
                  },
                  child: const Text('Visit ShadyAI on GitHub 🚀'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
