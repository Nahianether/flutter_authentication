import 'package:flutter/material.dart';
import 'package:flutter_authentication/src/modules/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  final container = ProviderContainer();
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}
