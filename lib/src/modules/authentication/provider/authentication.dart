import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final textProvider = Provider.family((_, String __) {
  return TextEditingController();
});

final isLogginedProvider = StateProvider<bool?>((ref) {
  return null;
});

final signUpErrorTextProvider = StateProvider<String?>((ref) {
  return null;
});

final authStatusToggle = StateProvider<bool>((ref) {
  return true;
});

final authCountryValue = StateProvider<String?>((ref) {
  return null;
});

final authStateValue = StateProvider<String?>((ref) {
  return null;
});

final authCityValue = StateProvider<String?>((ref) {
  return null;
});

final passwordMatch = StateProvider<bool>((ref) {
  ref.watch(textProvider('AuthPassword')).text !=
      ref.watch(textProvider('AuthConfirmPassword')).text;
  return false;
});
