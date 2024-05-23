import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

import '../../controller/check_switch.dart';
import '../../controller/time_picker_controller.dart';
import '../../model/add_task_model.dart';
import '../../service/hive_database.dart';
import '../main_pages/task_details.dart';

class ToDoCarddd extends StatefulWidget {
  const ToDoCarddd({super.key});

  @override
  State<ToDoCarddd> createState() => _ToDoCardddState();
}

class _ToDoCardddState extends State<ToDoCarddd> {
  HiveService get2 = Get.put(HiveService());
  int selectedTabIndex = 0;
  DateTimePicker dateTimePicker = Get.put(DateTimePicker());
  IsSwitched mySelectedDate = Get.put(IsSwitched());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: get2.toDoTasks.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  mySelectedDate.changeSwitch(false);
                  Get.to(OnTapTask(tasks: get2.toDoTasks[index]));
                },
                child: oneTaskView(get2.toDoTasks[index]),
              );
            },
          ),
        ));
  }
}

Widget oneTaskView(Tasks task) {
  String savedDateString = task.endTime!;

  // Parse the saved date string into a DateTime object
  DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(savedDateString);

  // Extract the day, month, and year
  int day = parsedDate.day;
  int month = parsedDate.month;
  int year = parsedDate.year;

  return Row(
    children: [
      SizedBox(width: 10),
      Container(
        height: 130,
        width: 230,
        decoration: BoxDecoration(
            color: Color(0xffe7f3ff), borderRadius: BorderRadius.circular(18)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15.0, left: 15, right: 15),
                  child: Text(
                    task.projectName!,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black45,
                        fontSize: 13),
                  ),
                ),
                Expanded(child: Container()),
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
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.only(left: 12, right: 10),
              child: Text(task.description!,
                  maxLines: 2,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
            ),
            Expanded(child: SizedBox(height: 5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text('Until: $day-$month-$year',
                    style: TextStyle(fontSize: 15)),
                SizedBox(width: 10)
              ],
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
      SizedBox(width: 15)
    ],
  );
}
