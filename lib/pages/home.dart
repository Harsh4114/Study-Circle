// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously, must_be_immutable, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, prefer_interpolation_to_compose_strings, unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'loginpage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    Center(child: Text('Home Screen')),
    Center(child: Text('Search Screen')),
    Center(child: Text('Profile Screen')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: Icon(Icons.logout),
          ),
        ],
        title: Center(child: Text("CodeBlock")),
        backgroundColor: Colors.blue[100],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
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
