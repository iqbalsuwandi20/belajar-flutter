import 'package:get/get.dart';

class Controller extends GetxController {
  var student = 0.obs;
  var teacher = 0.obs;

  addStudentAttendance() {
    return student.value++;
  }

  removeStudentAttendance() {
    if (student.value > 0) {
      return student.value--;
    }
  }

  addTeacherAttendance() {
    return teacher.value++;
  }

  removeTeacherAttendance() {
    if (teacher.value > 0) {
      return teacher.value--;
    }
  }

  sumTotally() {
    return student.value + teacher.value;
  }
}
