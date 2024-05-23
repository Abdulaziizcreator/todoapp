import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:todo/service/hive_database.dart';

import '../../model/add_task_model.dart';

Widget allTaskView(Tasks task) {
  HiveService hiveService = Get.put(HiveService());
  bool check = task.projectName == null;
  Widget emptySvg() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: SvgPicture.asset(
            "assets/svg/empty.svg",
            height: 200,
            width: 200,
          ),
        ),
        const Text("Data empty"),
      ],
    );
  }

  return !check
      ? Container(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
          margin:
              const EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    task.projectName!,
                    maxLines: 1,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, right: 8),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                          color: Colors.pink.shade50,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Icon(
                          task.taskGroup! == "Work"
                              ? IconlyBold.work
                              : (task.taskGroup! == "Daily Study"
                                  ? CupertinoIcons.book_fill
                                  : CupertinoIcons.profile_circled),
                          size: 24,
                          color: Colors.pink.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Text(
                      softWrap: true,
                      task.description!,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 17,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Container(
                    child: IconButton(
                      onPressed: () {
                        hiveService.deleteObj(objKey: task.key!);
                        hiveService.tasksList;
                      },
                      icon: Icon(
                        Icons.delete_forever,
                        size: 30,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.access_time_filled_rounded,
                    color: Colors.indigoAccent.shade200,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    "10:00 AM",
                    style: TextStyle(
                        fontSize: 13, color: Colors.indigoAccent.shade200),
                  ),
                  Expanded(child: Container()),
                  Container(
                    margin: const EdgeInsets.only(left: 4, top: 4, right: 4),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xff5f33e1).withOpacity(0.1)),
                    child: Text(
                      "done",
                      style: TextStyle(
                          fontSize: 12, color: Colors.indigoAccent.shade200),
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      : emptySvg();
}
