import 'package:get/get.dart';
import '../../auth/controller/sign_in_controller.dart';
import '../../auth/controller/otp_controller.dart';
import '../../auth/controller/register_controller.dart';
import '../../auth/controller/kyc_controller.dart';
import '../../profile/controller/profile_controller.dart';
import '../../home/controller/dashboard_controller.dart';
import '../../home/controller/create_group_controller.dart';
import '../../services/api/api_service.dart';

class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DioApiClient(), fenix: true);
    
    Get.lazyPut(() => SignInController(), fenix: true);
    Get.lazyPut(() => RegisterController(), fenix: true);
    Get.lazyPut(() => OtpController(), fenix: true);
    Get.lazyPut(() => KycController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => DashboardController(), fenix: true);
    Get.lazyPut(() => CreateGroupController(), fenix: true);
  }
}
