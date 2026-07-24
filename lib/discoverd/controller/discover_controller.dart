import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/api/api_end_point.dart';
import '../../services/api/api_service.dart';
import '../../utils/log/app_utils.dart';
import '../../utils/constants/app_string.dart';
import '../data/discover_group_model.dart';
import '../../component/bottom_nav_bar/bottom_nav_controller.dart';
import '../../groups/controller/groups_controller.dart';

class DiscoverController extends GetxController {
  final DioApiClient _apiClient = DioApiClient();
  
  var allGroups = <DiscoverGroupModel>[].obs;
  var filteredGroups = <DiscoverGroupModel>[].obs;
  var isLoading = false.obs;
  var isJoining = false.obs;
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchAllGroups();
  }

  Future<void> fetchAllGroups() async {
    isLoading.value = true;
    try {
      final response = await _apiClient.get(ApiEndPoint.getAllGroups);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data']['data'];
        allGroups.value = data.map((json) => DiscoverGroupModel.fromJson(json)).toList();
        filteredGroups.value = allGroups;
      } else {
        Utils.errorSnackBar(AppString.someThingWrong.tr, response.message);
      }
    } catch (e) {
      Utils.errorSnackBar(AppString.someThingWrong.tr, e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void filterGroups(String query) {
    if (query.isEmpty) {
      filteredGroups.value = allGroups;
    } else {
      filteredGroups.value = allGroups
          .where((group) =>
              (group.name ?? "").toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  Future<void> joinGroup(String groupId) async {
    isJoining.value = true;
    try {
      final response = await _apiClient.post("${ApiEndPoint.joinGroup}$groupId");
      
      if (Get.isDialogOpen ?? false) Get.back();

      if (response.statusCode == 200 || response.statusCode == 201) {
        Utils.successSnackBar(AppString.joinedGroupSuccess.tr);

        if (Get.isRegistered<GroupsController>()) {
          Get.find<GroupsController>().fetchMyGroups();
        } else {
          Get.put(GroupsController()).fetchMyGroups();
        }

        if (Get.isRegistered<BottomNavController>()) {
          Get.find<BottomNavController>().selectedIndex.value = 1;
        }
      } else {
        Utils.errorSnackBar(AppString.joinFailed.tr, response.message);
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back();
      
      Utils.errorSnackBar(AppString.someThingWrong.tr, e.toString());
    } finally {
      isJoining.value = false;
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
