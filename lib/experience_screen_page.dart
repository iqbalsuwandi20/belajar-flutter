import 'package:flutter/material.dart';

class ExperienceScreenPage extends StatelessWidget {
  const ExperienceScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pengalaman"),
      ),
      body: Center(
        child: Text("Pengalaman saya belajar di ITBOX"),
      ),
    );
  }
}
