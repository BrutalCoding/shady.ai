import 'dart:async';
import 'dart:ffi' as ffi;
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart' as p;
import 'package:shady_ai/generated/rwkv/rwkv_bindings.g.dart';
import 'package:url_launcher/url_launcher.dart';

Future<String> loadModelFile() async {
  // TODO: For the time being, please add your model file to the assets/rwkv folder.
  final String fileNameOfYourModel = 'daddy.bin';

  // Get the path of the model file
  String modelFilePath = p.join('assets', 'rwkv', fileNameOfYourModel);
  final data = await rootBundle.load(modelFilePath);

  // Create a temporary file and write the data to it
  final tempFile = File("${Directory.systemTemp.path}/$fileNameOfYourModel");

  await tempFile.writeAsBytes(data.buffer.asUint8List());

  // Return the path of the temporary model file
  return tempFile.path;
}

void main() {
  runApp(const Main());
}

Future<ffi.DynamicLibrary> loadLibrwkv() async {
  // Load the dynamic library according to the platform
  String libFileName;
  if (Platform.isMacOS) {
    libFileName = 'librwkv.dylib';
    // } else if (Platform.isAndroid) {
    // libFileName = 'librwkv.dylib';
  } else {
    throw UnsupportedError('This platform is not supported yet.');
  }

  // Get the path of the dynamic library
  String libPath = p.join('assets', 'rwkv', libFileName);
  final data = await rootBundle.load(libPath);

  // Create a temporary file and write the data to it
  final tempFile = File("${Directory.systemTemp.path}/$libFileName");
  await tempFile.writeAsBytes(data.buffer.asUint8List());

  // Load the dynamic library from the temporary file
  return ffi.DynamicLibrary.open(tempFile.path);
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
  // Load the model and evaluate it
  // Returns true if the evaluation was successful
  Future<bool> _loadModel() async {
    RWKV? rwkv;
    Pointer<rwkv_context>? ctx;
    try {
      rwkv = RWKV(await loadLibrwkv());
      final modelFilePath = await loadModelFile();
      final modelFilePathCStr = modelFilePath.toNativeUtf8().cast<Char>();
      ctx = rwkv.rwkv_init_from_file(modelFilePathCStr, 1);

      final state_buffer = rwkv.rwkv_get_state_buffer_element_count(ctx);
      final Pointer<Float> state_buffer_ptr =
          malloc.allocate<Float>(state_buffer);

      final logits_buffer = rwkv.rwkv_get_logits_buffer_element_count(ctx);
      final Pointer<Float> logits_buffer_ptr =
          malloc.allocate<Float>(logits_buffer);

      // TODO(BrutalCoding): Get the token from the user (e.g. via a text field or calculate it from the input)
      final token = 103;

      final result = rwkv.rwkv_eval(
        ctx,
        token,
        state_buffer_ptr,
        state_buffer_ptr,
        logits_buffer_ptr,
      );

      return result;
    } catch (e) {
      // Show an error message with ScaffoldMessenger
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
    if (rwkv == null || ctx == null) return false;
    rwkv.rwkv_free(ctx);

    return false;
  }

  Future<bool>? evalResult;

  @override
  void initState() {
    evalResult = _loadModel();
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
            onPressed: () {
              // Display a dialog with information about the app.
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('About ShadyAI'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SelectableText(
                          'ShadyAI is a project by BrutalCoding.\n'
                          'Its currently in a very early stage of development.\n\n'
                          "The app is currently only able to load in a model file and evaluate it. This does proof that the model file can be loaded and evaluated, and that's it.\n\n"
                          'Coming Soon: Chat UI, drag-and-drop your AI models & built-in models.\n'
                          'Coming Later: Adding more models, adding more features, adding more platforms.\n\n'
                          'Please check out the GitHub repository for more information.',
                        ),
                        SizedBox(height: 8),
                        ListTile(
                          leading: Icon(Icons.link),
                          title: Text(
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
                          leading: Icon(Icons.link),
                          title: Text(
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
                          leading: Icon(Icons.link),
                          title: Text(
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
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'AI Evaluation Result...',
                            style: textTheme.headlineMedium,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          'The app may freeze several times. This is normal.',
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        FutureBuilder(
                          future: evalResult,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return snapshot.data == true
                                  ? const Text(
                                      'The AI model is working correctly.',
                                      style: TextStyle(color: Colors.green),
                                    )
                                  : const Text(
                                      'The AI model is not working correctly.',
                                      style: TextStyle(color: Colors.red),
                                    );
                            } else if (snapshot.hasError) {
                              return const Text(
                                'An error occurred while evaluating the AI model.',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 500,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Text(
                          "Dev instructions:\nAdd your model in 'shady.ai/shady_ai_flutter/assets/rwkv' and name it 'daddy.bin' 🚧",
                          style: textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () => _loadModel(),
                    child: const Text('Retry'),
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
