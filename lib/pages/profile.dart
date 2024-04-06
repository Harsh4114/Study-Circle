// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unnecessary_brace_in_string_interps, use_build_context_synchronously, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:codeblock/pages/Edit_Profile.dart';
import 'package:codeblock/pages/setting.dart';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // top bar part

        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
              "Profile",
              style: TextStyle(
                  fontFamily: 'Profile',
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SettingPage()));
                },
                child: Icon(
                  Icons.settings,
                  size: 25.0,
                )),
            SizedBox(
              width: 10.0,
            )
          ],
        ),

        // main Body part

        body: ListView(
          children: [
            // Profile Image
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: CircleAvatar(
                radius: 50.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            // User Name & Email Address
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                        FirebaseAuth.instance.currentUser!.displayName
                            .toString(),
                        style: TextStyle(
                          fontFamily: 'Profile',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        )),

                    // Stream builder start from here
                    // StreamBuilder<QuerySnapshot>(
                    //   stream: FirebaseFirestore.instance
                    //       .collection("user")
                    //       .snapshots(),
                    //   builder: (BuildContext context,
                    //       AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                    //     return Text(user.toString(),
                    //         style: TextStyle(
                    //             fontFamily: 'Profile',
                    //             fontSize: 10.0,
                    //             fontWeight: FontWeight.bold));
                    //   },
                    // ),

                    // Stream builder end here
                    SizedBox(
                      width: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                            FirebaseAuth.instance.currentUser!.email.toString(),
                            style: TextStyle(
                                fontFamily: 'Profile',
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          Icons.verified_user_outlined,
                          color: Colors.green,
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
            // Edit Profile Button
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, right: 80.0, left: 80.0),
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Edit_Profile()));
                  },
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 50.0)),
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Profile',
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  )),
            ),

            // top bar for changing Section

            // Post Section Start from here
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Text(
                      //   "Posts",
                      //   style: TextStyle(
                      //       fontFamily: 'Profile',
                      //       fontSize: 25.0,
                      //       fontWeight: FontWeight.bold),
                      // ),
                      // Text(
                      //   "Posts",
                      //   style: TextStyle(
                      //       fontFamily: 'Profile',
                      //       fontSize: 25.0,
                      //       fontWeight: FontWeight.bold),
                      // ),
                      Text(
                        "Posts",
                        style: TextStyle(
                            fontFamily: 'Profile',
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 400,
                    child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              height: 250.0,
                              decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(20.0)),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

// Log out function start from here
}
