import 'package:belajar_flutter_maps/models/firebase_user.dart';
import 'package:belajar_flutter_maps/screens/authentication/handler.dart';
import 'package:belajar_flutter_maps/screens/home/home.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser?>(context);

    if (user == null) {
      return const Handler();
    } else {
      return const Home();
    }
  }
}
