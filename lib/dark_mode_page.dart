import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DarkModePage extends StatefulWidget {
  const DarkModePage({super.key});

  @override
  State<DarkModePage> createState() => _DarkModePageState();
}

class _DarkModePageState extends State<DarkModePage> {
  String mode = "Dark";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dark Mode Page'),
      ),
      body: Center(
        child: Column(
          children: [
            ListTile(
              leading: Radio<String>(
                  value: "Dark",
                  groupValue: mode,
                  onChanged: (value) {
                    setState(() {
                      Get.changeTheme(ThemeData.dark());
                      mode = value!;
                    });
                  }),
              title: const Text("Dark Mode"),
            ),
            ListTile(
              leading: Radio<String>(
                  value: "Light",
                  groupValue: mode,
                  onChanged: (value) {
                    setState(() {
                      mode = value!;
                      Get.changeTheme(ThemeData.light());
                    });
                  }),
              title: const Text("Light Mode"),
            )
          ],
        ),
      ),
    );
  }
}
