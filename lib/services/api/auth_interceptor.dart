import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import '../../config/route/app_routes.dart';
import '../storage/storage_services.dart';

class AuthInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // স্টোরেজ থেকে সরাসরি টোকেন নিয়ে হেডারে অ্যাড করা হচ্ছে
    final String token = LocalStorage.token;
    
    options.headers.addAll({
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // যদি এপিআই ৪MDE (Unauthorized) রেসপন্স দেয়, তবে অটো লগআউট
    if (err.response?.statusCode == 401) {
      _handleLogout();
    }
    super.onError(err, handler);
  }

  void _handleLogout() async {
    // সব লোকাল ডাটা ক্লিয়ার করে লগইন স্ক্রিনে পাঠিয়ে দেয়া
    await LocalStorage.removeAllPrefData();
    getx.Get.offAllNamed(AppRoutes.login);
  }
}
