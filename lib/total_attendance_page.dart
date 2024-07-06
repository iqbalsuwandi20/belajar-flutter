import 'package:belajar_flutter_getx/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TotalAttendancePage extends StatelessWidget {
  TotalAttendancePage({super.key});

  final Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Total Attendance Page"),
      ),
      body: Center(
        child: Column(
          children: [
            const Text("Total School Attendance"),
            Text(controller.sumTotally().toString())
          ],
        ),
      ),
    );
  }
}
