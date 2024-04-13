// ignore_for_file: prefer_const_constructors, file_names, non_constant_identifier_names, unused_local_variable, body_might_complete_normally_nullable, use_build_context_synchronously, prefer_const_literals_to_create_immutables
// import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeblock/pages/loginpage.dart';
// import 'package:codeblock/widget.dart';
// import 'package:codeblock/Service/AUTHENTICATION/Authentication.dart';
// import 'package:codeblock/pages/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
// import 'package:flutter/widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String data = "Add Post";
  TextEditingController topicController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  void addpost() async {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(25.0),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Profile"),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close))
                  ],
                ),
                SizedBox(height: 10),
                Container(
                    height: 1,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    )),
                SizedBox(height: 15),
                TextField(
                  controller: topicController,
                  decoration: InputDecoration(
                      hintText: "Topic",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                      hintText: "Description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
                  child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          data = "Adding Post";
                        });
                        String topic = topicController.text;
                        String description = descriptionController.text;
                        descriptionController.clear();
                        topicController.clear();
                        dynamic time = DateTime.now();

                        String user = FirebaseAuth
                            .instance.currentUser!.displayName
                            .toString();

                        await FirebaseFirestore.instance
                            .collection("Posts")
                            .add({
                          "Topic": topic.isEmpty ? "No Topic" : topic,
                          "Description": description.isEmpty
                              ? "No Description"
                              : description,
                          "Time": time,
                          "Post": user,
                          "Email": FirebaseAuth.instance.currentUser!.email
                        }).then((value) => setState(() {
                                  data = "Add Post";
                                  Navigator.pop(context);
                                }));
                      },
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(5),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue[100])),
                      child: Text("Add Post")),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Under Development"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // addpost();
          FirebaseAuth.instance.signOut().then((value) => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Loginpage())));
        },
        hoverColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }
}
