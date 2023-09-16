import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme.g.dart';

@riverpod
class AppTheme extends _$AppTheme {
  ThemeMode get mode => state;
  @override
  ThemeMode build() {
    return ThemeMode.system;
  }
}
