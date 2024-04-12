// ignore_for_file: non_constant_identifier_names, unused_local_variable, prefer_const_constructors, avoid_print, use_build_context_synchronously, unused_catch_clause, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, unnecessary_brace_in_string_interps, use_key_in_widget_constructors

import 'package:codeblock/Service/AUTHENTICATION/Authentication.dart';
import 'package:codeblock/pages/page_navi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Waiting extends StatefulWidget {
  final String email;
  final String password;
  final String name;
  const Waiting(
      {Key? key,
      required this.email,
      required this.password,
      required this.name});

  @override
  State<Waiting> createState() => _WaitingState();
}

class _WaitingState extends State<Waiting> {
  bool _isLoading = false;
  double percent = 0.0; // Initial value for percent

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
    setState(() {
      percent = 0.2;
    });
    try {
      await Authentication().SignUp(email, password, name).then((_) {
        setState(() {
          // Show an error message using SnackBar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("User Created Successfully"),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red, // Set the behavior to floating
            ),
          );
        });
      });
      setState(() {
        percent = 0.5;
      });

      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
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
    } finally {
      setState(() {
        _isLoading = false;
        percent = 1.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? Center(
              child: LinearPercentIndicator(
                animation: true,
                lineHeight: 5,
                animationDuration: 2000,
                percent: percent, // Set the percent value here
                progressColor: Colors.green,
              ),
            )
          : HomeScreen(),
    );
  }
}
