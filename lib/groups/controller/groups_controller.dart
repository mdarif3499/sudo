import 'package:get/get.dart';
import '../../config/api/api_end_point.dart';
import '../../services/api/api_service.dart';
import '../../utils/log/app_utils.dart';
import '../../../utils/constants/app_string.dart';
import '../data/group_model.dart';

class GroupsController extends GetxController {
  final DioApiClient _apiClient = DioApiClient();
  
  var groupsList = <GroupModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyGroups();
  }

  Future<void> fetchMyGroups() async {
    isLoading.value = true;
    try {
      final response = await _apiClient.get(ApiEndPoint.getMyGroups);
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        groupsList.value = data.map((json) => GroupModel.fromJson(json)).toList();
      } else {
        Utils.errorSnackBar(AppString.someThingWrong.tr, response.message);
      }
    } catch (e) {
      Utils.errorSnackBar(AppString.someThingWrong.tr, e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
