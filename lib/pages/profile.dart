// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Current User
  final User user = FirebaseAuth.instance.currentUser!;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  _fetchUserData() async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('user').doc(user.email).get();
    if (documentSnapshot.exists) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      print(data);
    } else {
      print('Document does not exist on the database');
    }
  }

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
                  'Click to fetch user data',
                  style:
                      TextStyle(fontSize: 20.0, color: Colors.blueAccent[200]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
