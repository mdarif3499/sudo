import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../storage/storage_keys.dart';
import '../storage/storage_services.dart';

class LanguageController extends GetxController {
  final RxString selectedLanguage = 'English'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadLanguage();
  }

  void _loadLanguage() {
    String code = LocalStorage.languageCode;
    if (code == 'es') {
      selectedLanguage.value = 'Spanish';
    } else {
      selectedLanguage.value = 'English';
    }
  }

  void changeLanguage(String language, String langCode, String countryCode) async {
    selectedLanguage.value = language;
    Locale locale = Locale(langCode, countryCode);
    Get.updateLocale(locale);
    
    await LocalStorage.setString(LocalStorageKeys.languageCode, langCode);
    await LocalStorage.setString(LocalStorageKeys.countryCode, countryCode);
  }
}
