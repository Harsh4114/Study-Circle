// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, unnecessary_brace_in_string_interps, use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeblock/pages/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'This is the settings page',
              style: TextStyle(fontSize: 24),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, right: 80.0, left: 80.0),
              child: OutlinedButton(
                  onPressed: () {
                    logout(context);
                  },
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 50.0)),
                  child: Text(
                    "LogOut",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Profile',
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void logout(BuildContext context) async {
    final FirebaseFirestore _firebasestore = FirebaseFirestore.instance;
    String Currentuser = FirebaseAuth.instance.currentUser!.email.toString();
    dynamic time = DateTime.now();

    try {
      await _firebasestore
          .collection("logout information")
          .doc(Currentuser)
          .set({
        'Email': Currentuser,
        'Logout Information': " ${Currentuser} Log out on ${time}",
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
    }

    try {
      await FirebaseAuth.instance.signOut().then((value) =>
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Loginpage())));
      setState(() {
        // Show an error message using SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(
              child: Text(
                "Logged Out Successfully.",
                style: TextStyle(color: Colors.black),
              ),
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Color.fromARGB(
                255, 38, 248, 182), // Set the behavior to floating
          ),
        );
      });
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Loginpage()));
    } catch (error) {
      String mess = error.toString();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error occurred while logging out" + mess),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
