import 'package:belajar_flutter_getx/controller.dart';
import 'package:belajar_flutter_getx/total_attendance_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SchoolPage extends StatelessWidget {
  SchoolPage({super.key});

  final Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("School Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            // ignore: prefer_const_constructors
            Text("Student Attendance"),
            Row(
              children: [
                Container(
                    width: 80,
                    height: 80,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: const Icon(Icons.present_to_all)),
                GestureDetector(
                  onTap: () {
                    controller.addStudentAttendance();
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blueAccent),
                    child: const Icon(Icons.add),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Obx(() => Text(controller.student.toString())),
                const SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () {
                    controller.removeStudentAttendance();
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blueAccent),
                    child: const Icon(Icons.remove),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            // ignore: prefer_const_constructors
            Text("Teacher Attendance"),
            Row(
              children: [
                Container(
                    width: 80,
                    height: 80,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: const Icon(Icons.present_to_all)),
                GestureDetector(
                  onTap: () {
                    controller.addTeacherAttendance();
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blueAccent),
                    child: const Icon(Icons.add),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Obx(() => Text(controller.teacher.toString())),
                const SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () {
                    controller.removeTeacherAttendance();
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blueAccent),
                    child: const Icon(Icons.remove),
                  ),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  Get.to(TotalAttendancePage());
                },
                child: const Text("Go to total Attendance"))
          ],
        ),
      ),
    );
  }
}
