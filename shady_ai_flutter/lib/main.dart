import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:shady_ai_client/shady_ai_client.dart';
import 'package:url_launcher/url_launcher.dart';

// Sets up a singleton client object that can be used to talk to the server from
// anywhere in our app. The client is generated from your server code.
// The client is set up to connect to a Serverpod running on a local server on
// the default port. You will need to modify this to connect to staging or
// production servers.
var client = Client('http://localhost:8080/')
  ..connectivityMonitor = FlutterConnectivityMonitor();

void main() {
  // final onnyxSessiojn = bindings.
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
                          ]),
                    );
                  },
                );
              }),
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
                    style: Theme.of(context).textTheme.displayLarge,
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
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Sending you to GitHub..."),
                      ),
                    );
                    await launchUrl(
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
