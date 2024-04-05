// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unnecessary_brace_in_string_interps, use_build_context_synchronously, prefer_interpolation_to_compose_strings

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeblock/pages/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Current User
  final User user = FirebaseAuth.instance.currentUser!;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: ListView(
        children: [
          // Profile Picture
          Container(
            padding: EdgeInsets.all(20.0),
            child: CircleAvatar(
              radius: 50.0,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.person,
                size: 30.0,
                color: Colors.white,
              ),
            ),
          ),
          // Edit profile button
          Padding(
            padding: EdgeInsets.only(
                top: 20.0, bottom: 20.0, right: 60.0, left: 60.0),
            child: Container(
              height: 50.0,
              decoration: BoxDecoration(
                border: Border.all(
                    width: 2.0, color: Color.fromARGB(255, 74, 134, 252)),
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  'Edit Profile',
                  style:
                      TextStyle(fontSize: 20.0, color: Colors.blueAccent[200]),
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(
                top: 20.0, bottom: 20.0, right: 60.0, left: 60.0),
            child: Container(
              height: 50.0,
              decoration: BoxDecoration(
                border: Border.all(
                    width: 2.0, color: Color.fromARGB(255, 74, 134, 252)),
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  '${user.email}',
                  style:
                      TextStyle(fontSize: 20.0, color: Colors.blueAccent[200]),
                ),
              ),
            ),
          ),
// logout button
          IconButton(
              onPressed: () {
                logout(context);
              },
              icon: Icon(Icons.logout))
        ],
      ),
    );
  }

// Log out function start from here
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
      await FirebaseAuth.instance.signOut();
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
