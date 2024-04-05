// ignore_for_file: unused_local_variable, unused_catch_clause, prefer_const_constructors, avoid_print, deprecated_member_use, non_constant_identifier_names, camel_case_types, prefer_final_fields, unused_field, use_key_in_widget_constructors, use_build_context_synchronously, file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeblock/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class collectingdata extends StatefulWidget {
  final String email;
  final String password;

  const collectingdata(this.email, this.password);

  @override
  State<collectingdata> createState() => _collectingdataState();
}

class _collectingdataState extends State<collectingdata> {
  bool _isSaving = true; // Initially set to true to automatically save data
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  final FirebaseFirestore _firebasestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    emailcontroller.text = widget.email;
    passwordcontroller.text = widget.password;
    _saveUserData(emailcontroller.text, passwordcontroller.text);
  }

  Future<void> _saveUserData(String email, String password) async {
    setState(() {
      _isSaving = true;
    });

    Map<String, dynamic> userData = {
      'Email': email,
      'Password': password,
      'Time': DateTime.now(),
    };

    try {
      await _firebasestore.collection("user").doc(email).set(userData);

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
            ? Center(child: Lottie.asset("assets/mp4/loading.json"))
            : HomeScreen(), // No button needed
      ),
    );
  }
}
