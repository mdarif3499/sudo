import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sudo/config/route/app_routes.dart';

class KycController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  var governmentIdPath = "".obs;
  var proofOfAddressPath = "".obs;
  var selfiePath = "".obs;

  bool get isAllUploaded =>
      governmentIdPath.isNotEmpty &&
      proofOfAddressPath.isNotEmpty &&
      selfiePath.isNotEmpty;

  Future<void> pickDocument(int step) async {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Select Source",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () async {
                Get.back();
                final XFile? image = await _picker.pickImage(
                  source: ImageSource.camera,
                );
                _setPath(step, image?.path);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Gallery"),
              onTap: () async {
                Get.back();
                final XFile? image = await _picker.pickImage(
                  source: ImageSource.gallery,
                );
                _setPath(step, image?.path);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _setPath(int step, String? path) {
    if (path != null) {
      if (step == 1) {
        governmentIdPath.value = path;
      } else if (step == 2) {
        proofOfAddressPath.value = path;
      } else if (step == 3) {
        selfiePath.value = path;
      }
    }
  }

  void submitKyc() {
    if (isAllUploaded) {
      Get.toNamed(AppRoutes.docSubmitted);
    }
  }
}
