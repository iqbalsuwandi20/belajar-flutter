import 'package:belajar_flutter_maps/screens/authentication/login.dart';
import 'package:belajar_flutter_maps/screens/authentication/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Handler extends StatefulWidget {
  const Handler({super.key});

  @override
  State<Handler> createState() => _HandlerState();
}

class _HandlerState extends State<Handler> {
  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Login(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
