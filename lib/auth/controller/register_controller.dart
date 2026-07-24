import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/countries.dart';
import '../../services/api/api_client.dart';
import '../../services/api/api_service.dart';
import '../../config/api/api_end_point.dart';
import '../../utils/log/app_utils.dart';
import '../../config/route/app_routes.dart';
import '../../utils/constants/app_string.dart';
import '../../services/api/multipart_helper.dart';

class RegisterController extends GetxController {
  final ApiClient _apiClient = DioApiClient();
  final ImagePicker _picker = ImagePicker();
  final formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Default country code
  String countryCode = "+234"; 

  final profileImagePath = "".obs;
  final isLoading = false.obs;

  void onCountryChange(Country country) {
    countryCode = "+${country.dialCode}";
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImagePath.value = image.path;
    }
  }

  Future<void> signUp() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      List<MultipartFileItem> files = [];
      if (profileImagePath.isNotEmpty) {
        files.add(MultipartFileItem(
          fileName: 'image',
          filePath: profileImagePath.value,
        ));
      }

      // Combining country code with phone number
      final fullPhoneNumber = "$countryCode${phoneController.text.trim()}";

      final response = await _apiClient.multipart(
        url: ApiEndPoint.signUp,
        files: files,
        body: {
          'fullName': fullNameController.text.trim(),
          'email': emailController.text.trim(),
          'phoneNumber': fullPhoneNumber,
          'address': addressController.text.trim(),
          'password': passwordController.text.trim(),
        },
      );

      if (response.isSuccess) {
        Utils.successSnackBar(response.message);
        Get.toNamed(AppRoutes.otp, parameters: {'email': emailController.text.trim()});
      } else {
        Utils.errorSnackBar(AppString.registrationFailed.tr, response.message);
      }
    } catch (e) {
      Utils.errorSnackBar(AppString.someThingWrong.tr, e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
