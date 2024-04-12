// ignore_for_file: file_names, non_constant_identifier_names, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Authentication {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore DB = FirebaseFirestore.instance;

  // new user registration
  Future<void> SignUp(String email, String password, String name) async {
    //Update the user name and email
    await auth.currentUser!.updateDisplayName(name);
    await auth.currentUser!.verifyBeforeUpdateEmail(email);

    // store user data in database
    Map<String, dynamic> data = {
      "Name": name,
      "Email": email,
      "Password": password,
      "Created On": DateTime.now(),
      "Last LogOut": "Not Logged Out Yet",
    };

    await DB.collection("Users").doc(email).set(data);
  }

  // user login
  Future<void> SignIn(String email, String password) async {
    // Update the user last login time
    await DB
        .collection("Users")
        .doc(email)
        .update({"Created On": DateTime.now()});
  }

  // user logout
  Future<void> SignOut(String CurrentUser) async {
    // update the user last logout time
    await DB
        .collection("Users")
        .doc(CurrentUser)
        .update({"Last LogOut": DateTime.now()});
  }
}
