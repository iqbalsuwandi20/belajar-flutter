import 'package:flutter/material.dart';

class EducationScreenPage extends StatelessWidget {
  const EducationScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pendidikan"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Pengalaman saya belajar di ITBOX"),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamedAndRemoveUntil("/", (route) => false);
                },
                child: Text("Kembali kehalaman pertama"))
          ],
        ),
      ),
    );
  }
}
