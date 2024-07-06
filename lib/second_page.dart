import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SeccondPageState();
}

class _SeccondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("This is Second Page"),
      ),
      body: Center(
        child: Column(
          children: [
            const Text("This is Second Page"),
            ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Back to Main Page"))
          ],
        ),
      ),
    );
  }
}
