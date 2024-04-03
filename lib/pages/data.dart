// ignore_for_file: unused_local_variable, unused_catch_clause, prefer_const_constructors, avoid_print, deprecated_member_use, non_constant_identifier_names, camel_case_types, prefer_final_fields, unused_field, use_key_in_widget_constructors, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeblock/pages/home.dart';
import 'package:flutter/material.dart';

class collectingdata extends StatefulWidget {
  final String email;
  final String password;

  const collectingdata(this.email, this.password);

  @override
  State<collectingdata> createState() => _collectingdataState();
}

class _collectingdataState extends State<collectingdata> {
  bool _obscureText = true;
  bool _isSaving = true; // Initially set to true to automatically save data
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  final FirebaseFirestore _firebasestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    // Set initial values for controllers
    emailcontroller.text = widget.email;
    passwordcontroller.text = widget.password;

    // Save data automatically when the widget is initialized
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
            content: Text("Process Done."),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green[200], // Set the behavior to floating
          ),
        );
      });
      // Navigate to home screen after saving data
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
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
            ? CircularProgressIndicator() // Show CircularProgressIndicator if saving data
            : SizedBox(), // No button needed
      ),
    );
  }
}
