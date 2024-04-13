// ignore_for_file: prefer_const_constructors, file_names, non_constant_identifier_names, unused_local_variable, body_might_complete_normally_nullable

import 'package:cloud_firestore/cloud_firestore.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: IconButton(
                    onPressed: () {
                      final String? user =
                          FirebaseAuth.instance.currentUser?.email;
                      FirebaseAuth.instance.signOut().then((value) {
                        Authentication().SignOut(user!);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Loginpage()));
                      });
                    },
                    icon: Icon(Icons.logout_outlined)),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Posts")
                      .orderBy("Time", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> data =
                                  snapshot.data!.docs[index].data()
                                      as Map<String, dynamic>;

                              return Card(
                                color: Colors.lightBlue[100],
                                child: ListTile(
                                  leading: Text(
                                    data["Post"],
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  title: Text(data["Topic"]),
                                  subtitle: Text(data["Description"]),
                                  onLongPress: () {
                                    snapshot.data!.docs[index].reference
                                        .delete();
                                  },
                                  // trailing: Text(data["Post By"]),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return Text("No Data Found");
                      }
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          dynamic time = DateTime.now();
          String user =
              FirebaseAuth.instance.currentUser!.displayName.toString();
          await FirebaseFirestore.instance.collection("Posts").add({
            "Topic": "Try",
            "Description": "Flutter is a UI toolkit",
            "Time": time,
            "Post": user,
          });
          print("Data Added");
        },
        hoverColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }
}
