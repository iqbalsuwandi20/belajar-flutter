import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Home Test"),
        leading: Icon(Icons.arrow_back_ios),
        actions: [Icon(Icons.notifications_active), Icon(Icons.history)],
      ),
    );
  }
}
