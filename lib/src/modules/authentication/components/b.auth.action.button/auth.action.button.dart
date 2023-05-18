import 'package:flutter/material.dart';

class AuthActionButton extends StatelessWidget {
  const AuthActionButton({
    required this.title,
    this.onPressed,
    Key? key,
    required AnimationController? animationSigninController,
  })  : _animationSigninController = animationSigninController,
        super(key: key);

  final AnimationController? _animationSigninController;
  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0,
      width: 100.0,
      child: ElevatedButton(
        onPressed: () async {
          onPressed?.call();
          //context.pop();
          //_animationSigninController!.dispose();
        },
        child: Text(title),
      ),
    );
  }
}
