import 'package:belajar_flutter_maps/models/login_user.dart';
import 'package:belajar_flutter_maps/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function? toggleView;
  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool obscureText = true;

  final email = TextEditingController();
  final password = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final Auth _auth = Auth();
  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      controller: email,
      decoration: const InputDecoration(labelText: "Email"),
      autofocus: false,
    );

    final passwordField = TextFormField(
      obscureText: obscureText,
      controller: password,
      decoration: const InputDecoration(labelText: "Password"),
      autofocus: false,
    );

    final loginButton = TextButton(
      onPressed: () {
        widget.toggleView;
      },
      child: const Text("Kembali Login"),
    );

    final registerButton = ElevatedButton(
      onPressed: () async {
        if (_globalKey.currentState!.validate()) {
          dynamic result = await _auth.registerEmail(
            LoginUser(email: email.text, password: password.text),
          );
          if (result.uid == null) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(result.code),
                  );
                });
          }
        }
      },
      child: const Text("Register"),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do List"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
              child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                emailField,
                const SizedBox(
                  height: 20,
                ),
                passwordField,
                const SizedBox(
                  height: 20,
                ),
                registerButton,
                const SizedBox(
                  height: 20,
                ),
                loginButton
              ],
            ),
          ))
        ],
      ),
    );
  }
}
