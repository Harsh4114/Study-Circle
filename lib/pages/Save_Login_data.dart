// ignore_for_file: unused_local_variable, unused_catch_clause, prefer_const_constructors, avoid_print, deprecated_member_use, non_constant_identifier_names, camel_case_types, prefer_final_fields, unused_field, use_key_in_widget_constructors, use_build_context_synchronously, file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeblock/pages/page_navi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class collectingdata extends StatefulWidget {
  final String email;
  final String password;
  final String name;

  const collectingdata(this.name, this.email, this.password);

  @override
  State<collectingdata> createState() => _collectingdataState();
}

class _collectingdataState extends State<collectingdata> {
  bool _isSaving = true; // Initially set to true to automatically save data
  double _progress = 0.0; // Progress percentage
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();

  final FirebaseFirestore _firebasestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    emailcontroller.text = widget.email;
    passwordcontroller.text = widget.password;
    namecontroller.text = widget.name;
    _saveUserData(
        namecontroller.text, emailcontroller.text, passwordcontroller.text);
  }

  Future<void> _saveUserData(String name, String email, String password) async {
    setState(() {
      _isSaving = true;
    });

    FirebaseAuth.instance.currentUser!.updateDisplayName(name);

    Map<String, dynamic> userData = {
      'Name': name,
      'Email': email,
      'Password': password,
      'Time': DateTime.now(),
      "Phone Number": "",
    };

    try {
      await _firebasestore.collection("user").doc(email).set(userData);
    } on FirebaseFirestore catch (error) {
      String Error = error.toString();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(Error),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ),
      );
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
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(), // Circular progress indicator
                  SizedBox(height: 20),
                  Text(
                    '${(_progress * 100).toStringAsFixed(1)}% Progress', // Progress percentage text
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              )
            : HomeScreen(), // No button needed
      ),
    );
  }
}
