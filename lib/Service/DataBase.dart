// ignore_for_file: non_constant_identifier_names, unused_local_variable, prefer_const_constructors, avoid_print, use_build_context_synchronously, unused_catch_clause, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, unnecessary_brace_in_string_interps, file_names, empty_catches, unused_element, prefer_typing_uninitialized_variables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeblock/Service/verification.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataBase {
  final FirebaseFirestore _firebasestore = FirebaseFirestore.instance;

  // Save New User Data
  void SaveUserData(
      String email, String password, String name, int phone) async {
    FirebaseAuth.instance.currentUser!.updateDisplayName(name);

    Map<String, dynamic> userData = {
      'Name': name,
      'Email': email,
      'Password': password,
      'Time': DateTime.now(),
      "Phone Number": phone,
    };

    await _firebasestore.collection("user").doc(email).set(userData);
    // Process Completed Successfully
    EmailVerificationChecker();
  }

  // Update Already Existing User Data
  void LogIn(String email) {
    // Update User Data
    dynamic Time = DateTime.now();
    _firebasestore
        .collection("Login Information")
        .doc(email)
        .update({'Time': Time});

    EmailVerificationChecker();
  }

  void LogOut(String email) {
    // Update User Data
    FirebaseAuth.instance.signOut();
    dynamic Time = DateTime.now();
    _firebasestore
        .collection("LogOut Information")
        .doc(email)
        .update({'Time': Time});
  }
}
