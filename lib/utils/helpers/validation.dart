import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../constants/app_string.dart';

class AppValidation {
  AppValidation._();

  static final emailRegexp = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

  static final passRegExp = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$');

  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppString.thisFieldIsRequired.tr;
    }
    return null;
  }

  static String? email(String? value) {
    final error = required(value);
    if (error != null) return error;

    if (!emailRegexp.hasMatch(value!)) {
      return AppString.enterValidEmail.tr;
    }
    return null;
  }

  static String? password(String? value) {
    final error = required(value);
    if (error != null) return error;
    if (value!.length < 8) {
      return AppString.passwordMustBeeEightCharacters.tr;
    }
    return null;
  }

  static String? confirmPassword(
    String? value,
    TextEditingController passwordController,
  ) {
    final error = required(value);
    if (error != null) return error;

    if (value != passwordController.text) {
      return AppString.thePasswordDoesNotMatch.tr;
    }
    return null;
  }
}
