import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication/src/extensions/extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/a.header.text/header.text.dart';
import 'components/b.auth.action.button/auth.action.button.dart';
import 'components/c.have.account.or.not.text.button/have.account.or.not.text.button.dart';
import 'provider/authentication.dart';
import '../../constant/constant.dart';

class AuthenticationPopup extends ConsumerStatefulWidget {
  const AuthenticationPopup({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SignInPopupState();
}

class SignInPopupState extends ConsumerState<AuthenticationPopup>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationSigninController;
  Animation<double>? _animationSignin;
  String address = '';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _animationSigninController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animationSignin = CurvedAnimation(
        parent: _animationSigninController!, curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    _animationSigninController!.forward();
    return ScaleTransition(
      scale: _animationSignin!,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: SizedBox(
          height: context.height * 0.7,
          width:
              context.width < 550 ? context.width * 0.6 : context.width * 0.3,
          child: context.isMobile
              ? SingleChildScrollView(
                  child: mainContent(context),
                )
              : mainContent(context),
        ),
      ),
    );
  }

  Padding mainContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ref.watch(authStatusToggle)
                ? const HeaderText(
                    title: 'Sign In',
                  )
                : const HeaderText(
                    title: 'Sign Up',
                  ),
            const SizedBox(height: 20.0),
            ref.watch(authStatusToggle)
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 5.0,
                    ),
                    child: TextFormField(
                      controller: ref.watch(textProvider('AuthName')),
                      decoration: InputDecoration(
                        hintText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (name) {
                        if (name!.isEmpty) {
                          return 'Please enter name';
                        }
                        return null;
                      },
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 5.0,
              ),
              child: TextFormField(
                controller: ref.watch(textProvider('AuthEmail')),
                decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (email) {
                  if (email!.isEmpty) {
                    return 'Please enter email';
                  } else if (!emailValidatorRegExp.hasMatch(email)) {
                    return 'Please enter valid email';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 5.0,
              ),
              child: TextFormField(
                controller: ref.watch(textProvider('AuthPassword')),
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (pass) {
                  if (pass!.isEmpty) {
                    return 'Please enter a password';
                  } else if (pass.length < 6) {
                    return 'Password should be at least 6 characters';
                  }
                  return null;
                },
              ),
            ),
            ref.watch(authStatusToggle)
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 5.0,
                    ),
                    child: TextFormField(
                      controller:
                          ref.watch(textProvider('AuthConfirmPassword')),
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (pass) {
                        if (pass !=
                            ref.watch(textProvider('AuthPassword')).text) {
                          return 'Password not matched!';
                        }
                        return null;
                      },
                    ),
                  ),
            ref.watch(authStatusToggle)
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 5.0),
                    child: CSCPicker(
                      dropdownDecoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.grey.shade300, width: 1)),
                      disabledDropdownDecoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: Colors.grey.shade300,
                          border: Border.all(
                              color: Colors.grey.shade300, width: 1)),
                      selectedItemStyle: TextStyle(
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                      onCountryChanged: (value) {
                        ref
                            .read(authCountryValue.notifier)
                            .update((state) => value);
                      },
                      onStateChanged: (value) {
                        ref
                            .read(authStateValue.notifier)
                            .update((state) => value);
                      },
                      onCityChanged: (value) {
                        ref
                            .read(authCityValue.notifier)
                            .update((state) => value);
                      },
                    ),
                  ),
            const SizedBox(
              height: 10,
            ),
            ref.watch(signUpErrorTextProvider) != null
                ? Text(
                    ref.watch(signUpErrorTextProvider)!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 20.0),
            ref.watch(authStatusToggle)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AuthActionButton(
                        animationSigninController: _animationSigninController,
                        title: 'Sign In',
                        onPressed: () async {},
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AuthActionButton(
                        animationSigninController: _animationSigninController,
                        title: 'Sign Up',
                        onPressed: () async {},
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
            const SizedBox(height: 20.0),
            ref.watch(authStatusToggle)
                ? HaveAccountOrNotTextButton(
                    ref: ref,
                    title: 'Sign Up',
                    text: 'Don\'t have an account?',
                    middleText: 'Click here to  ',
                  )
                : HaveAccountOrNotTextButton(
                    ref: ref,
                    title: 'Sign In',
                    text: 'Already have an account?',
                    middleText: 'Click here to  ',
                  ),
          ],
        ),
      ),
    );
  }
}
