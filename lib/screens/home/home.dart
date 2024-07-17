import 'package:belajar_flutter_maps/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Auth auth = Auth();
  @override
  Widget build(BuildContext context) {
    final signOut = IconButton(
      onPressed: () async {
        await auth.signOut();
      },
      icon: const Icon(Icons.logout),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [signOut],
      ),
    );
  }
}
