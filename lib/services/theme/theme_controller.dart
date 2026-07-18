import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../storage/storage_keys.dart';
import '../storage/storage_services.dart';

class ThemeController extends GetxController {
  // ১. অবজারভেবল ভেরিয়েবল
  final isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    // ২. অ্যাপ চালুর সময় স্টোরেজ থেকে ডাটা লোড করা
    isDarkMode.value = LocalStorage.getBool(LocalStorageKeys.isDarkMode);
    
    // ৩. মেমোরি ভেরিয়েবল সিঙ্ক রাখা
    LocalStorage.isDarkMode = isDarkMode.value;
  }

  ThemeMode get themeMode => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  // ৪. থিম টগল করার মেথড
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    
    // ৫. লোকাল স্টোরেজে সাথে সাথে সেভ করা (Persistence)
    LocalStorage.setBool(LocalStorageKeys.isDarkMode, isDarkMode.value);
    
    // ৬. গেটক্স এর ইন্টারনাল থিম চেঞ্জ ট্রিগার করা
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}
