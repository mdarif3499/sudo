import 'package:get/get.dart';

class ProfileController extends GetxController {
  var isNotificationOn = true.obs;

  void toggleNotification(bool value) {
    isNotificationOn.value = value;
  }
}
