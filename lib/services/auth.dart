import 'package:belajar_flutter_maps/models/firebase_user.dart';
import 'package:belajar_flutter_maps/models/login_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseUser? firebaseUser(User? user) {
    return user != null ? FirebaseUser(uid: user.uid) : null;
  }

  Stream<FirebaseUser?> get user {
    return auth.authStateChanges().map(firebaseUser);
  }

  Future signInEmail(LoginUser loginUser) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginUser.email.toString(),
        password: loginUser.password.toString(),
      );
      User? user = userCredential.user;
      return firebaseUser(user);
    } on FirebaseAuthException catch (e) {
      return FirebaseUser(code: e.code, uid: null);
    }
  }

  Future registerEmail(LoginUser loginUser) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: loginUser.email.toString(),
        password: loginUser.password.toString(),
      );
      User? user = userCredential.user;
      return firebaseUser(user);
    } on FirebaseAuthException catch (e) {
      return FirebaseUser(code: e.code, uid: null);
    } catch (e) {
      return FirebaseUser(code: e.toString(), uid: null);
    }
  }

  Future signOut() async {
    try {
      return await auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
