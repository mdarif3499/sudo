import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../config/api/api_end_point.dart';
import '../../../services/api/api_service.dart';
import '../../../services/api/multipart_helper.dart';
import '../../../utils/log/app_utils.dart';
import '../../../config/route/app_routes.dart';
import '../../../component/bottom_nav_bar/bottom_nav_controller.dart';
import '../../../utils/constants/app_string.dart';
import 'profile_controller.dart';

class EditProfileController extends GetxController {
  final DioApiClient _apiClient = DioApiClient();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  final isLoading = false.obs;
  var selectedImagePath = "".obs;
  final ImagePicker _picker = ImagePicker();
  
  String? imageUrl;

  @override
  void onInit() {
    super.onInit();
    final data = Get.arguments as Map<String, dynamic>?;
    if (data != null) {
      fullNameController.text = data['fullName'] ?? "";
      emailController.text = data['email'] ?? "";
      phoneController.text = data['phoneNumber'] ?? "";
      addressController.text = data['address'] ?? "";
      imageUrl = data['image'];
    }
  }

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

  Future<void> saveChanges() async {
    isLoading.value = true;
    try {
      final List<MultipartFileItem> files = [];
      if (selectedImagePath.isNotEmpty) {
        files.add(MultipartFileItem(
          filePath: selectedImagePath.value,
          fileName: 'image',
        ));
      }

      final Map<String, String> body = {
        'fullName': fullNameController.text.trim(),
        'phoneNumber': phoneController.text.trim(),
        'address': addressController.text.trim(),
      };

      final response = await _apiClient.multipart(
        url: ApiEndPoint.updateProfile,
        method: 'PATCH',
        files: files,
        body: body,
      );

      if (response.statusCode == 200) {
        Utils.successSnackBar(AppString.profileUpdatedSuccess.tr);
        // Refresh profile data
        if (Get.isRegistered<ProfileController>()) {
          Get.find<ProfileController>().fetchProfile();
        }
        Get.toNamed(AppRoutes.main);
        Get.find<BottomNavController>().changeIndex(3);
      } else {
        Utils.errorSnackBar(AppString.someThingWrong.tr, response.message);
      }
    } catch (e) {
      debugPrint("===> Update Profile Error: $e");
      Utils.errorSnackBar(AppString.someThingWrong.tr, "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }
}
