import 'package:belajar_flutter_authentication/models/firebase_user.dart';
import 'package:belajar_flutter_authentication/screens/authenticate/handler.dart';
import 'package:belajar_flutter_authentication/screens/home/home.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser?>(context);

    if (user == null) {
      // ignore: prefer_const_constructors
      return Handler();
    } else {
      return const Home();
    }
  }
}
