// ignore_for_file: non_constant_identifier_names, unused_local_variable, prefer_const_constructors, avoid_print, use_build_context_synchronously, unused_catch_clause, prefer_const_literals_to_create_immutables, camel_case_types, use_key_in_widget_constructors, unused_element
import 'package:codeblock/pages/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';

class Login_Data_save extends StatefulWidget {
  final String email;
  final String password;

  const Login_Data_save(this.email, this.password);

  @override
  State<Login_Data_save> createState() => _Login_Data_saveState();
}

class _Login_Data_saveState extends State<Login_Data_save> {
  bool _isSaving = true;
  final FirebaseFirestore _firebasestore = FirebaseFirestore.instance;

  Future<void> _saveUserData(String email, String password) async {
    setState(() {
      _isSaving = true;
    });

    try {
      await _firebasestore.collection("Login Information").doc(email).set({
        'Email': email,
        'Password': password,
        'Login Time': DateTime.now(),
      });

      setState(() {
        // Show an error message using SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color:
                    Colors.orangeAccent, // Changing the color to orangeAccent
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                "Login Successfuly",
                style: TextStyle(
                    color: Colors.black), // Changing the text color to black
              ),
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.white, // Set the behavior to floating
          ),
        );
      });
    } on FirebaseFirestore catch (error) {
      String Error = error.toString();
      setState(() {
        // Show an error message using SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(Error),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red, // Set the behavior to floating
          ),
        );
      });
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isSaving
            ? Center(
                child: Lottie.asset(
                    "assets/mp4/loading.json")) // Show CircularProgressIndicator if saving data
            : Loginpage(), // No button needed
      ),
    );
  }
}
