import 'package:get/get.dart';

class CreateGroupController extends GetxController {
  final selectedFrequency = "Weekly".obs;
  final selectedVisibility = "Private".obs;
  final selectedDuration = "2 Weeks".obs;

  void setFrequency(String value) {
    selectedFrequency.value = value;
    if (value == "Weekly") {
      selectedDuration.value = "2 Weeks";
    } else if (value == "Monthly") {
      selectedDuration.value = "1 Month";
    } else if (value == "Quarterly") {
      selectedDuration.value = "2 Months";
    }
  }

  void setVisibility(String value) {
    selectedVisibility.value = value;
  }

  void setDuration(String value) {
    selectedDuration.value = value;
  }
}
