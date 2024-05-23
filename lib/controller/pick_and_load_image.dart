import 'dart:io';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../service/image_picker.dart';
import '../service/store_image.dart';

class ImageController extends GetxController {
  var image = Rx<File?>(null); // Use Rx<File?> to handle nullability
  var isEditing = false.obs;
  var userName = "User Name".obs; // Default user name
  var isNotificationEnabled = false.obs;

  void toggleEditing() {
    isEditing.value = !isEditing.value;
  }

  void updateUserName(String newName) {
    userName.value = newName;
  }
  @override
  void onInit() {
    super.onInit();
    loadImage(); // Load image when the controller is initialized
  }

  void pickImage() async {
    try {
      final _image = await ImagePickerService.pickImagefromGallery();
      if (_image != null) {
        final path = _image.path;
        final id = await DatabaseHelper().insertImage(path);
        image.value = File(path);
        Logger().i("Image saved with ID: $id");
            }
    } catch (e) {
      Logger().e("Failed to pick image: $e");
    }
  }

  void loadImage() async {
    try {
      String? imagePath = await DatabaseHelper().getImage();
      if (imagePath != null) {
        image.value = File(imagePath);
        Logger().i("Loaded image path: $imagePath");
      } else {
        Logger().i("No image found in database");
      }
    } catch (e) {
      Logger().e("Failed to load image: $e");
    }
  }
}
