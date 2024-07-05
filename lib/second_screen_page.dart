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
          title: Text("Second Screen Page"),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("This is Second Screen Page"))
            ],
          ),
        ));
  }
}
