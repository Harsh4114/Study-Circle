// ignore_for_file: prefer_const_constructors, file_names, non_constant_identifier_names

import 'package:codeblock/Service/AUTHENTICATION/Authentication.dart';
import 'package:codeblock/pages/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int number = 0;
  String Data = " ";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: IconButton(
                onPressed: () {
                  final String user =
                      FirebaseAuth.instance.currentUser!.email.toString();
                  FirebaseAuth.instance.signOut().then((value) {
                    Authentication().SignOut(user);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Loginpage()));
                  });
                },
                icon: Icon(Icons.logout_outlined)),
          ),
          Text("$number $Data"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            number++;
            if (number % 2 == 0) {
              setState(() {
                Data = "Is Even";
              });
            } else {
              setState(() {
                Data = "Is Odd";
              });
            }
          });
        },
        hoverColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }
}
