// ignore_for_file: non_constant_identifier_names, unused_local_variable, prefer_const_constructors, avoid_print, use_build_context_synchronously, unused_catch_clause, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, unnecessary_brace_in_string_interps, library_private_types_in_public_api, sort_child_properties_last
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _emailController = TextEditingController();

  Future<void> _sendPasswordResetEmail(BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password reset email sent'),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('you forgot to enter your email.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Forget Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Lottie.asset('assets/mp4/profile.json',
                    height: 160, width: 150),
                Image.asset(
                  "assets/photo/lock.png",
                  height: 150,
                  width: 150,
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "\tPlease enter your email to reset \n\tyour password.",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Profile',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: " Email ",
                  prefixStyle:
                      const TextStyle(color: Colors.black, fontSize: 15),
                  labelStyle: const TextStyle(color: Colors.black),
                  prefixIcon: const Icon(Icons.mail),
                  prefixIconColor: Colors.black,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.blue[200],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            CoolSubmitButton(
              onPressed: () {
                final _email = _emailController.text.trim();

                _sendPasswordResetEmail(context).then((value) =>
                    FirebaseFirestore.instance
                        .collection('Password Rest Link')
                        .doc(_emailController.text)
                        .set({
                      'Email': _emailController.text,
                      'Time': DateTime.now(),
                    }));
                _emailController.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CoolSubmitButton extends StatefulWidget {
  final VoidCallback onPressed;

  const CoolSubmitButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  _CoolSubmitButtonState createState() => _CoolSubmitButtonState();
}

class _CoolSubmitButtonState extends State<CoolSubmitButton> {
  bool _isLoading = false;

  void _handleSubmit() {
    setState(() {
      _isLoading = true;
    });
    // Simulating some asynchronous operation
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
      // After the operation is completed, call the provided onPressed callback
      widget.onPressed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 80.0, right: 80.0),
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleSubmit,
        child: _isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                'Submit',
                style: TextStyle(fontSize: 16),
              ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
          shadowColor: Colors.blue,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
