// ignore_for_file: non_constant_identifier_names, unused_local_variable, prefer_const_constructors, avoid_print, use_build_context_synchronously, unused_catch_clause, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, unnecessary_brace_in_string_interps, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors_in_immutables, await_only_futures

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  final String email;
  final String password;
  final String name;
  final int phoneNumber;

  SignUpScreen(
      {required this.email,
      required this.password,
      required this.name,
      required this.phoneNumber});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isEmailVerified = false;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _createUserWithEmailAndPassword();
  }

  Future<void> _createUserWithEmailAndPassword() async {
    try {
      // Show linear progress indicator
      setState(() {
        _progress = 0.25;
      });

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: widget.email,
        password: widget.password,
      );

      // Send email verification link
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();

      // Update progress
      setState(() {
        _progress = 0.5;
      });

      // Check if email is verified
      Emailverfication();

      // Update progress
      setState(() {
        _progress = 0.75;
      });
      // Store data into Firestore
      await FirebaseFirestore.instance
          .collection('user')
          .doc(widget.email)
          .set({
        'name': widget.name,
        'phoneNumber': widget.phoneNumber,
      });

      // Update progress
      setState(() {
        _progress = 1.0;
      });

      // Navigate to home screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (error) {
      setState(() {
        // Show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${error.toString()}'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ),
        );
      });
    }
  }

  void Emailverfication() async {
    await FirebaseAuth.instance.currentUser!.reload();
    (await FirebaseAuth.instance.currentUser!.emailVerified)
        ? setState(() {
            _progress = 6.0;
          })
        : Emailverfication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(value: _progress),
            SizedBox(height: 20),
            Text(_isEmailVerified ? 'Email verified!' : 'Verifying email...'),
            SizedBox(height: 20),
            _isEmailVerified
                ? ElevatedButton(
                    onPressed: () {
                      // Proceed to next screen or do something else
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    child: Text('Continue'),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Welcome to the Home Screen!'),
      ),
    );
  }
}
