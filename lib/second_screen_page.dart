import 'package:belajar_flutter_intermediate/experience_screen_page.dart';
import 'package:flutter/material.dart';

class SecondScreenPage extends StatefulWidget {
  const SecondScreenPage({super.key});

  @override
  State<SecondScreenPage> createState() => _SecondScreenPageState();
}

class _SecondScreenPageState extends State<SecondScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Second Screen Page"),
        ),
        body: Center(
          child: Column(
            children: [
              Text("Nama saya Iqbal"),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return ExperienceScreenPage();
                    }));
                  },
                  child: Text("Lihat pengalaman")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed("educationPage");
                  },
                  child: const Text("Lihat Pendidikan")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamedAndRemoveUntil(("/"), (route) => false);
                  },
                  child: Text("Kembali kehalaman pertama")),
            ],
          ),
        ));
  }
}
