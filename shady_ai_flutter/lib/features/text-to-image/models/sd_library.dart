import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';

typedef perform_task_func = Pointer<Utf8> Function(Pointer<Utf8> input);
typedef PerformTask = Pointer<Utf8> Function(Pointer<Utf8> input);

class SdLibrary {
  late final DynamicLibrary _dylib;

  SdLibrary(String pathToDynamicLibrary) {
    _dylib = Platform.isMacOS
        ? DynamicLibrary.open(pathToDynamicLibrary)
        : throw UnsupportedError('Unsupported platform');
  }

  PerformTask get performTask {
    return _dylib.lookupFunction<perform_task_func, PerformTask>('txt2img');
  }
}
