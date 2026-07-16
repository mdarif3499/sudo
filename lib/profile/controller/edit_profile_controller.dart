import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  final fullNameController = TextEditingController(text: "John Doe");
  final emailController = TextEditingController(text: "john@example.com");
  final phoneController = TextEditingController(text: "+1 (555) 000-0000");
  final addressController = TextEditingController(text: "123 Main St, New York, NY 10001");

  var selectedImagePath = "".obs;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      selectedImagePath.value = image.path;
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.onClose();
  }

  void saveChanges() {
    // Implement save logic with selectedImagePath.value
    Get.back();
  }
}
