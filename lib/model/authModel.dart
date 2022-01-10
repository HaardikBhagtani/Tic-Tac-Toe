import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthModel {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  createNewUser(String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return 'Registration Successful. Now Login.';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return "Your email address appears to be malformed.";
      } else if (e.code == "email-already-in-use") {
        return "Email already registered. Please login.";
      } else {
        return e.code;
      }
    }
  }

  signIn(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return 'Log in Successful.';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return "Your email address appears to be malformed.";
      } else if (e.code == "wrong-password") {
        return "Your password is wrong.";
      } else if (e.code == 'user-not-found') {
        return 'User with this email doesn\'t exist.\nPlease register.';
      } else {
        return e.code;
      }
    }
  }

  logOut() async {
    await firebaseAuth.signOut();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
