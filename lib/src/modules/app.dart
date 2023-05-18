import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerWidget, WidgetRef;

import 'authentication/authentication.dart';

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainView(),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            showDialog(
              context: context,
              builder: (context) => const AuthenticationPopup(),
            );
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
