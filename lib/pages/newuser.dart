// ignore_for_file: unused_local_variable, unused_catch_clause, prefer_const_constructors, avoid_print, deprecated_member_use, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:codeblock/pages/data.dart';
import 'package:codeblock/pages/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Newuser extends StatefulWidget {
  const Newuser({super.key});

  @override
  State<Newuser> createState() => _NewuserState();
}

class _NewuserState extends State<Newuser> {
  bool _obscureText = true;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  loginfun(String email, String password) async {
    if (emailcontroller.text.isEmpty || passwordcontroller.text.isEmpty) {
      if (emailcontroller.text.isEmpty) {
        setState(() {
          // Show an error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(child: Text('Please Enter Email ')),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
            ),
          );
        });
      }
      if (passwordcontroller.text.isEmpty) {
        setState(() {
          // Show an error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(child: Text('Please Enter Passoword')),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
            ),
          );
        });
      }
      if (emailcontroller.text.isEmpty && passwordcontroller.text.isEmpty) {
        setState(() {
          // Show an error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(child: Text('Please Enter Both')),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
            ),
          );
        });
      }
    } else {
      UserCredential? userCredential;
      try {
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => collectingdata(email, password))));
      } on FirebaseAuthException catch (ex) {
        String Error = ex.message.toString();
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        bottom: false,
        child: ListView(
          padding: EdgeInsets.all(40),
          children: [
            const SizedBox(
              height: 40,
            ),
            Lottie.asset("assets/mp4/newuser.json", height: 150),
            const SizedBox(
              height: 25,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Email",
                  style: TextStyle(fontSize: 15, color: Colors.blue[400]),
                )
              ],
            ),
            TextField(
              controller: emailcontroller,
              decoration: InputDecoration(
                hintText: " Email ",
                prefixStyle: const TextStyle(color: Colors.black, fontSize: 15),
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

            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Password",
                  style: TextStyle(fontSize: 15, color: Colors.blue[400]),
                )
              ],
            ),
            // State variable to toggle password visibility

            TextField(
              controller: passwordcontroller,
              obscureText: _obscureText,
              decoration: InputDecoration(
                hintText: "Password",
                prefixStyle: const TextStyle(color: Colors.black, fontSize: 15),
                labelStyle: const TextStyle(color: Colors.black),
                prefixIcon: const Icon(Icons.password),
                prefixIconColor: Colors.black,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
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
            const SizedBox(
              height: 25,
            ),
            const SizedBox(
              height: 20,
            ),
            OutlinedButton(
              onPressed: () {
                String password = passwordcontroller.text.toString();
                String email = emailcontroller.text.toString();
                // Save login status to SQLite database
                loginfun(email, password);
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                    color: Colors.blue), // Border color of the button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10), // Rounded corners for the button
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 100), // Padding around the button text
              ),
              child: Center(
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue), // Text style for the button text
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have you Account? ",
                  style: TextStyle(fontSize: 16),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Loginpage()));
                    },
                    child: Text(
                      "Sign in",
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
