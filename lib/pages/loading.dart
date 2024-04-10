// ignore_for_file: non_constant_identifier_names, unused_local_variable, prefer_const_constructors, avoid_print, use_build_context_synchronously, unused_catch_clause, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, unnecessary_brace_in_string_interps, prefer_final_fields

import 'dart:async';

import 'package:codeblock/Service/AUTHENTICATION/Authentication.dart';
import 'package:codeblock/pages/page_navi.dart';
import 'package:codeblock/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Waiting extends StatefulWidget {
  final String email;
  final String password;
  final String name;
  const Waiting(
      {super.key,
      required this.email,
      required this.password,
      required this.name});

  @override
  State<Waiting> createState() => _WaitingState();
}

class _WaitingState extends State<Waiting> {
  bool _isLoading = false;
  @override
  void initState() {
    final Email = widget.email;
    final Password = widget.password;
    final Name = widget.name;
    super.initState();
    SaveData(Email, Name, Password);
  }

  void SaveData(String email, String name, String password) async {
    setState(() {
      _isLoading = true;
    });
    try {
      Authentication()
          .SignUp(email, password, name)
          .then((value) => setState(() {
                // Show an error message using SnackBar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("User Created Successfully"),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.red, // Set the behavior to floating
                  ),
                );
              }))
          .then((value) => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomeScreen())));
    } on FirebaseAuthException catch (ex) {
      setState(() {
        // Show an error message using SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: ${ex.message}"),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red, // Set the behavior to floating
          ),
        );
      });
    }
    Timer.periodic(Duration(seconds: 8), (timer) {
      setState(() {
        _isLoading = false;
        timer.cancel();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading ? Center(child: Loading()) : HomeScreen(),
    );
  }
}
