import 'package:shared_preferences/shared_preferences.dart';
import 'storage_keys.dart';
import '../../utils/log/app_log.dart';

class LocalStorage {
  static SharedPreferences? preferences;

  // Static variables for quick access
  static String token = "";
  static String refreshToken = "";
  static bool isLogIn = false;
  static String userId = "";
  static String myImage = "";
  static String myName = "";
  static String myEmail = "";
  static String role = "";
  static String plan = "";
  static String adminId = "";

  static Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
    await getAllPrefData();
  }

  static Future<SharedPreferences> _getStorage() async {
    preferences ??= await SharedPreferences.getInstance();
    return preferences!;
  }

  static Future<void> getAllPrefData() async {
    final localStorage = await _getStorage();

    token = localStorage.getString(LocalStorageKeys.token) ?? "";
    refreshToken = localStorage.getString(LocalStorageKeys.refreshToken) ?? "";
    isLogIn = localStorage.getBool(LocalStorageKeys.isLogIn) ?? false;
    userId = localStorage.getString(LocalStorageKeys.userId) ?? "";
    myImage = localStorage.getString(LocalStorageKeys.myImage) ?? "";
    myName = localStorage.getString(LocalStorageKeys.myName) ?? "";
    myEmail = localStorage.getString(LocalStorageKeys.myEmail) ?? "";
    role = localStorage.getString(LocalStorageKeys.role) ?? "";
    plan = localStorage.getString(LocalStorageKeys.plan) ?? "";
    adminId = localStorage.getString(LocalStorageKeys.adminId) ?? "";

    appLog(userId, source: "Local Storage");
  }

  /// Get methods
  static String getString(String key) {
    return preferences?.getString(key) ?? "";
  }

  static bool getBool(String key) {
    return preferences?.getBool(key) ?? false;
  }

  static int getInt(String key) {
    return preferences?.getInt(key) ?? 0;
  }

  /// Set methods
  static Future<void> setString(String key, String value) async {
    final localStorage = await _getStorage();
    await localStorage.setString(key, value);
    
    if (key == LocalStorageKeys.token) token = value;
    if (key == LocalStorageKeys.refreshToken) refreshToken = value;
    if (key == LocalStorageKeys.userId) userId = value;
    if (key == LocalStorageKeys.myImage) myImage = value;
    if (key == LocalStorageKeys.myName) myName = value;
    if (key == LocalStorageKeys.myEmail) myEmail = value;
    if (key == LocalStorageKeys.role) role = value;
    if (key == LocalStorageKeys.plan) plan = value;
    if (key == LocalStorageKeys.adminId) adminId = value;
  }

  static Future<void> setBool(String key, bool value) async {
    final localStorage = await _getStorage();
    await localStorage.setBool(key, value);
    if (key == LocalStorageKeys.isLogIn) isLogIn = value;
  }

  static Future<void> setInt(String key, int value) async {
    final localStorage = await _getStorage();
    await localStorage.setInt(key, value);
  }

  static Future<void> remove(String key) async {
    final localStorage = await _getStorage();
    await localStorage.remove(key);
  }

  static Future<void> removeAllPrefData() async {
    final localStorage = await _getStorage();
    await localStorage.clear();
    _resetLocalStorageVariables();
    await getAllPrefData();
  }

  static void _resetLocalStorageVariables() {
    token = "";
    refreshToken = "";
    isLogIn = false;
    userId = "";
    myImage = "";
    myName = "";
    myEmail = "";
    role = "";
    plan = "";
    adminId = "";
  }
}
