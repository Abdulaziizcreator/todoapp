import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ImageControllerCardPage extends GetxController {
  var image = Rxn<File?>(); // Rxn for nullable reactive type

  void setImage(File? newImage) {
    image.value = newImage;
  }
}

class CardScreen extends StatelessWidget {
   CardScreen({super.key});
  final ImageControllerCardPage imageController = Get.put(ImageControllerCardPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClipOval(
          child: Obx(() {
            final image = imageController.image.value;
            return image != null
                ? Image.file(
              image,
              width: 100, // The width should be double the radius
              height: 100, // The height should be double the radius
              fit: BoxFit.cover,
            )
                : SvgPicture.asset(
              "assets/svg/profile.svg",
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            );
          }),
        ),
      ),
    );
  }
}
