import 'package:get/get.dart';

class CreateGroupController extends GetxController {
  final selectedFrequency = "Weekly".obs;
  final selectedVisibility = "Private".obs;
  final selectedDuration = "2 Months".obs;

  void setFrequency(String value) {
    selectedFrequency.value = value;
  }

  void setVisibility(String value) {
    selectedVisibility.value = value;
  }

  void setDuration(String value) {
    selectedDuration.value = value;
  }
}
