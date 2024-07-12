import 'package:belajar_flutter_authentication/services/auth_service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final signOut = Material(
      child: MaterialButton(
        onPressed: () async {
          await authService.signOut();
        },
        child: const Text("Logout"),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Center(
        child: signOut,
      ),
    );
  }
}
