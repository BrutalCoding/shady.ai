import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const Main());
}

/// Main entry point for the app
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => showDialog<void>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('About ShadyAI'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SelectableText(
                        'ShadyAI is a project by BrutalCoding.\n'
                        'Its currently in a very early stage of development.\n\n'
                        "The app is currently only able to load in a model file and evaluate it. This does proof that the model file can be loaded and evaluated, and that's it.\n\n"
                        'Coming Soon: Chat UI, drag-and-drop your AI models & built-in models.\n'
                        'Coming Later: Adding more models, adding more features, adding more platforms.\n\n'
                        'Please check out the GitHub repository for more information.',
                      ),
                      const SizedBox(height: 8),
                      ListTile(
                        leading: const Icon(Icons.link),
                        title: const Text(
                          'ShadyAI on GitHub',
                        ),
                        onTap: () {
                          launchUrl(
                            Uri.parse(
                              'https://github.com/BrutalCoding/ShadyAI',
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
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/dad_the_benchmark.png',
                  width: 200,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            'Nothing to see here yet.',
                            style: textTheme.headlineMedium,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Text(
                          'Ongoing research and development, there is nothing noteworthy to show yet.',
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
