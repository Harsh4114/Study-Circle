// ignore_for_file: file_names, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Authentication {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore DB = FirebaseFirestore.instance;

  // new user registration
  Future<void> SignUp(String email, String password, String name) async {
    // create user with email and password
    dynamic user = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    //Update the user name and email
    await auth.currentUser!.updateDisplayName(name);
    await auth.currentUser!.verifyBeforeUpdateEmail(email);

    // store user data in database
    Map<String, dynamic> data = {
      "Name": name,
      "Email": email,
      "Password": password,
      "USer UID": user.user!.uid,
      "Created On": DateTime.now()
    };

    await DB.collection("Users").doc(email).set(data);

    // return user ; if user is created successfully
    return (user != null) ? user : null;
  }

  // user login
  Future<void> SignIn(String email, String password) async {
    // sign in user with email and password
    dynamic user =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    // Update the user last login time
    await DB
        .collection("Users")
        .doc(email)
        .update({"Created On": DateTime.now()});
    // return user ; if user is signed in successfully
    return (user != null) ? user : null;
  }
}
