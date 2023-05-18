import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/authentication.dart';

class HaveAccountOrNotTextButton extends StatelessWidget {
  const HaveAccountOrNotTextButton({
    Key? key,
    required this.title,
    required this.text,
    required this.ref,
    this.middleText,
  }) : super(key: key);

  final WidgetRef ref;
  final String title;
  final String text;
  final String? middleText;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: text),
          TextSpan(text: '\n $middleText'),
          TextSpan(
            text: title,
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                ref.read(authStatusToggle.notifier).update((s) => !s);
                ref.read(signUpErrorTextProvider.notifier).state = null;
              },
          ),
        ],
      ),
    );
  }
}
