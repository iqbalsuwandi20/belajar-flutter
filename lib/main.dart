import 'package:belajar_flutter_getx/dark_mode_page.dart';
import 'package:belajar_flutter_getx/second_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("State Management GetX"),
      ),
      body: Center(
          child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                // ignore: prefer_const_constructors
                Get.to(() => SecondPage());
              },
              child: const Text("Go to Seccond Page")),
          ElevatedButton(
              onPressed: () {
                // ignore: prefer_const_constructors
                Get.to(() => DarkModePage());
              },
              child: const Text("Go to Dark Mode Page"))
        ],
      )),
    );
  }
}
