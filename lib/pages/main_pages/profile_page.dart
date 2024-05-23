import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/controller/pick_and_load_image.dart';
import 'package:todo/service/hive_database.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImageController controller = Get.put(ImageController());

  HiveService hiveService = Get.put(HiveService());
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Profile Page',
          style: GoogleFonts.lato(color: Colors.black, fontSize: 24),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.blueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Obx(() {
                double avatarRadius = controller.isEditing.value ? 70 : 50;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        CircleAvatar(
                          radius: avatarRadius,
                          backgroundImage: controller.image.value != null
                              ? FileImage(controller.image.value!)
                              : AssetImage('assets/images/default_profile.png')
                                  as ImageProvider,
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 25),
                          child: IconButton(
                              onPressed: () {
                                controller.pickImage();
                              },
                              icon: Icon(
                                Icons.change_circle_outlined,
                                color: Colors.white,
                                size: 28,
                              )),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: controller.isEditing.value
                                ? TextField(
                                    controller: textEditingController,
                                    style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Enter your name',
                                      hintStyle: GoogleFonts.lato(
                                        color: Colors.white70,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  )
                                : Text(
                                    hiveService.getProfile() ??
                                        controller.userName.value,
                                    style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                          ),
                          IconButton(
                            icon: Icon(
                              controller.isEditing.value
                                  ? Icons.check
                                  : Icons.edit,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              if (controller.isEditing.value) {
                                controller
                                    .updateUserName(textEditingController.text);
                                hiveService.storeProfile(
                                    name: textEditingController.text.trim());
                              } else {
                                textEditingController.text =
                                    controller.userName.value;
                              }
                              controller.toggleEditing();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.notifications, color: Colors.blue),
                    title: Text(
                      'Notifications',
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Obx(
                      () => Switch(
                        value: controller.isNotificationEnabled.value,
                        onChanged: (value) {
                          controller.isNotificationEnabled.value = value;
                        },
                        activeColor: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
