# Implementation Plan - Profile Edit Functionality

Implement pre-filling of profile data in the Edit Profile screen and integrate the `PATCH /user/profile` API for updating user information, including image upload.

## User Review Required

> [!IMPORTANT]
> The Edit Profile API only supports `fullName`, `phoneNumber`, `address`, and `image`. The `email` field will be displayed as read-only or omitted from the update request as it's not shown in the provided API documentation image.

## Proposed Changes

### Configuration

#### [MODIFY] [api_end_point.dart](file:///C:/Users/mdyou/StudioProjects/sudo/lib/config/api/api_end_point.dart)
- Add `static const updateProfile = '/user/profile';`

### Profile Feature

#### [MODIFY] [profile_screen.dart](file:///C:/Users/mdyou/StudioProjects/sudo/lib/profile/screen/profile_screen.dart)
- Pass the profile data as arguments when navigating to the edit profile screen: `Get.toNamed(AppRoutes.editProfile, arguments: data);`

#### [MODIFY] [edit_profile_controller.dart](file:///C:/Users/mdyou/StudioProjects/sudo/lib/profile/controller/edit_profile_controller.dart)
- Initialize `DioApiClient`.
- Retrieve initial data from `Get.arguments` in `onInit`.
- Populate `TextEditingController`s with the provided data.
- Update `saveChanges` to:
    - Show a loading indicator.
    - Prepare multipart data (fields and optional image).
    - Call `_apiClient.multipart` with `PATCH` method.
    - Handle success by showing a snackbar, refreshing `ProfileController` data, and navigating back.
    - Handle errors by showing a snackbar.

#### [MODIFY] [edit_profile_screen.dart](file:///C:/Users/mdyou/StudioProjects/sudo/lib/profile/screen/edit_profile_screen.dart)
- Ensure the UI correctly reflects the loading state from the controller (adding `isLoading` obs to controller).
- Make the email field read-only if it's not updatable via the PATCH API.
- Update the profile image display to show the network image if no new image is selected.

## Verification Plan

### Automated Tests
- N/A (Project seems to rely on manual testing for UI/API integration)

### Manual Verification
1. Open the Profile screen.
2. Verify profile data is fetched and displayed.
3. Tap "Edit Profile".
4. Verify that the Edit Profile screen is pre-filled with the current profile data.
5. Change name, phone, and address.
6. Select a new profile image.
7. Tap "Save Changes".
8. Verify the loading state appears.
9. Verify the success snackbar appears.
10. Verify the screen navigates back to the Profile screen.
11. Verify the Profile screen shows the updated data.
