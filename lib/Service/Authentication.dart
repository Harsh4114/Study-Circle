// ignore_for_file: non_constant_identifier_names, unused_local_variable, prefer_const_constructors, avoid_print, use_build_context_synchronously, unused_catch_clause, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, unnecessary_brace_in_string_interps, file_names, empty_catches, unused_element, prefer_typing_uninitialized_variables, body_might_complete_normally_nullable

import 'package:codeblock/Service/DataBase.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailVerification {
  // Send email verification
  void sendEmailVerification(
      String email, String password, String name, int phone) async {
    await FirebaseAuth.instance.currentUser!
        .sendEmailVerification()
        .then((value) => DataBase().SaveUserData(email, password, name, phone));
  }

  void Sign_Up(String email, String password, String name, int phone) async {
    // Create user

    UserCredential? userCredential;
    userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      // Send email verification
      sendEmailVerification(email, password, name, phone);
    }); // calling function }
  }

  void Login(String email, String password) async {
    UserCredential? userCredential;
    userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      // Update User Data
      DataBase().LogIn(email);
    }); // calling function }
  }
}
