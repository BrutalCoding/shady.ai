// Load the model and evaluate it
// Returns true if the evaluation was successful
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:shady_ai/generated/rwkv/rwkv_bindings.g.dart';

Future<XFile?> openFileCheckpoint() async {
  const XTypeGroup typeGroup = XTypeGroup(
    label: 'model',
    extensions: <String>['bin'],
  );
  final XFile? file =
      await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);

  if (file == null) {
    // Operation was canceled by the user.
    return null;
  }

  return file;
}

// TODO(BrutalCoding): Finish implementing this
// ignore: unused_element
Future<bool> _loadModel(BuildContext context) async {
  RWKV? rwkv;
  Pointer<rwkv_context>? ctx;
  try {
    // Get path to AI model to infer
    final fileOfAiModel = await openFileCheckpoint();
    if (fileOfAiModel == null) {
      return false;
    }

    // Create a temporary file and write the data to it
    await fileOfAiModel.readAsBytes();

    // Get basename of the file using the path
    final fileNameOfYourModel = p.basename(fileOfAiModel.path);

    // Create a temporary file and write the data to it
    final tempFile = File("${Directory.systemTemp.path}/$fileNameOfYourModel");

    // await tempFile.writeAsBytes(data.buffer.asUint8List());
    final modelFilePath = tempFile.path;

    // Load the dynamic library
    rwkv = RWKV(await loadLibrwkv());
    final modelFilePathCStr = modelFilePath.toNativeUtf8().cast<Char>();
    ctx = rwkv.rwkv_init_from_file(modelFilePathCStr, 1);

    final stateBuffer = rwkv.rwkv_get_state_buffer_element_count(ctx);
    final Pointer<Float> stateBufferPtr = malloc.allocate<Float>(stateBuffer);

    final logitsBuffer = rwkv.rwkv_get_logits_buffer_element_count(ctx);
    final Pointer<Float> logitsBufferPtr = malloc.allocate<Float>(logitsBuffer);

    // TODO(BrutalCoding): Get the token from the user (e.g. via a text field or calculate it from the input)
    const token = 103;

    final result = rwkv.rwkv_eval(
      ctx,
      token,
      stateBufferPtr,
      stateBufferPtr,
      logitsBufferPtr,
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

Future<DynamicLibrary> loadLibrwkv() async {
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
  return DynamicLibrary.open(tempFile.path);
}
