import 'package:belajar_flutter_authentication/models/login_user.dart';
import 'package:belajar_flutter_authentication/services/auth_service.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final Function? toggleView;
  const Login({super.key, this.toggleView});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      controller: _email,
      decoration: const InputDecoration(hintText: "Email"),
      autofocus: false,
      validator: (value) {
        if (value!.contains('@') && value.endsWith(".com")) {
          return null;
        } else {
          return "Email tidak sesuai";
        }
      },
    );
    final passwordlField = TextFormField(
      controller: _password,
      autofocus: false,
      decoration: const InputDecoration(hintText: "Password"),
      validator: (value) {
        if (value!.isEmpty) {
          return "Password tidak boleh kosong";
        } else {
          return null;
        }
      },
    );
    final textButton = TextButton(
        onPressed: () {
          widget.toggleView!();
        },
        child: const Text("Belum terdaftar"));
    final loginAnonymousButton = Material(
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        onPressed: () async {
          dynamic result = await _authService.signInAnonymous();
          if (result.uid == null) {
            showDialog(
                // ignore: use_build_context_synchronously
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(result.code),
                  );
                });
          }
        },
        child: const Text("Sign in Anonymous"),
      ),
    );
    final loginEmailPasswordButton = Material(
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        onPressed: () async {
          if (_globalKey.currentState!.validate()) {
            dynamic result = await _authService.signInEmailPassword(
                LoginUser(email: _email.text, password: _password.text));
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
        child: const Text("Sign in Email"),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Test Auth"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
              key: _globalKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    emailField,
                    const SizedBox(
                      height: 20,
                    ),
                    passwordlField,
                    const SizedBox(
                      height: 20,
                    ),
                    textButton,
                    const SizedBox(
                      height: 20,
                    ),
                    loginAnonymousButton,
                    const SizedBox(
                      height: 20,
                    ),
                    loginEmailPasswordButton
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
