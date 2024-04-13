// ignore_for_file: prefer_const_constructors, file_names, non_constant_identifier_names, unused_local_variable, body_might_complete_normally_nullable, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeblock/Service/AUTHENTICATION/Authentication.dart';
import 'package:codeblock/pages/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                      "Add Post",
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
                        });
                        Future.delayed(Duration(seconds: 2));

                        Navigator.pop(context);
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
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(left: 25, right: 25, top: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Profile",
                  style: TextStyle(
                      fontFamily: 'Profile',
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
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
              ],
            ),
            SizedBox(height: 5),
            Container(
              width: double.maxFinite,
              height: 1,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: 20),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Posts")
                    .where("Post",
                        isEqualTo:
                            FirebaseAuth.instance.currentUser!.displayName)
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
                                trailing: IconButton(
                                    onPressed: () {
                                      snapshot.data!.docs[index].reference
                                          .delete();
                                    },
                                    icon: Icon(Icons.delete)),
                                leading: CircleAvatar(
                                  radius: 30,
                                  child: Text(
                                    data["Post"],
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                                title: Text(data["Topic"]),
                                subtitle: Text(data["Description"]),

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
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addpost();
        },
        hoverColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }
}
