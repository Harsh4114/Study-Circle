// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unnecessary_brace_in_string_interps, use_build_context_synchronously, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, sort_child_properties_last, camel_case_types, file_names, deprecated_member_use, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeblock/pages/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Edit_Profile extends StatefulWidget {
  const Edit_Profile({super.key});

  @override
  State<Edit_Profile> createState() => _Edit_ProfileState();
}

class _Edit_ProfileState extends State<Edit_Profile> {
  // All the variables
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController NewPasswordController = TextEditingController();
  final TextEditingController ConfirmPasswordController =
      TextEditingController();

  saveemail(String email, BuildContext context) async {
    print("Inside saveemail");

    try {
      await FirebaseAuth.instance.currentUser!.verifyBeforeUpdateEmail(email);
      print("Email Updated");

      await FirebaseFirestore.instance
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"Email": email});

      print("Firestore update successful");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email has been updated."),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ),
      );

      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Loginpage()));
    } catch (error) {
      print("Error updating email: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to update email: $error"),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(
              fontFamily: 'Profile',
              fontSize: 26,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20.0),
          Row(
            children: [
              SizedBox(width: 10.0),
              Text(
                "1 . Do you want to change your name?",
                style: TextStyle(
                    fontFamily: 'Profile',
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 10.0),
              GestureDetector(
                onTap: () {
                  // Show the dialog

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Change Phone Number'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'After changing the Name, Restart the App , After , In Profile Page you will see the updated Name.',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 20),
                            TextField(
                              controller: nameController,
                              decoration:
                                  InputDecoration(labelText: 'Enter New Name'),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Close'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Add functionality to update password
                              // This is where you would handle updating the password

                              dynamic name = nameController.text;
                              nameController.clear();

                              if (name != null) {
                                // Update the phone
                                FirebaseAuth.instance.currentUser!
                                    .updateDisplayName(name);
                                // Update the password in the database
                                FirebaseFirestore.instance
                                    .collection("user")
                                    .doc(FirebaseAuth
                                        .instance.currentUser!.email)
                                    .update({"Name": name});

                                // Show a SnackBar message
                                setState(() {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Name has been updated."),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors
                                          .red, // Set the behavior to floating
                                    ),
                                  );
                                });

                                Navigator.of(context).pop();
                              } else {
                                setState(() {
                                  // Show an error message using SnackBar
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Name not updated. Please try again."),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors
                                          .red, // Set the behavior to floating
                                    ),
                                  );
                                });
                              }
                            },
                            child: Text('Update'),
                          ),
                        ],
                      );
                    },
                  );

                  // dialog box end here
                },
                child: Text(
                  "\t\t\t\tChange Name",
                  style: TextStyle(
                      fontFamily: 'Profile',
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Row(
            children: [
              SizedBox(width: 10.0),
              Text(
                "2 . Do you want to change your Email?",
                style: TextStyle(
                    fontFamily: 'Profile',
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 10.0),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Change Email'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'After changing the Email , you will be logged out. You will have to login again. also you will see the updated Email in Profile Page and email verification link will be sent to your new email address.',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 20),
                            TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  labelText: 'Enter New Email Address'),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Close'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Add functionality to update password
                              // This is where you would handle updating the password

                              dynamic email = emailController.text;
                              emailController.clear();

                              if (email != null) {
                                // Update the email

                                saveemail(email, context);
                              } else {
                                setState(() {
                                  // Show an error message using SnackBar
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Phone Number not updated. Please try again."),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors
                                          .red, // Set the behavior to floating
                                    ),
                                  );
                                });
                              }
                            },
                            child: Text('Update'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  "\t\t\t\tChange Email",
                  style: TextStyle(
                      fontFamily: 'Profile',
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Row(
            children: [
              SizedBox(width: 10.0),
              Text(
                "3 . Do you want to change your Phone Number \n\t\t\t\t or Update It?",
                style: TextStyle(
                    fontFamily: 'Profile',
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 10.0),
              GestureDetector(
                onTap: () {
                  // Show the dialog

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Change Phone Number'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'After changing the Phone, In Profile Page you will see the updated Phone Number.',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 20),
                            TextField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  labelText: 'Enter Phone Number'),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Close'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Add functionality to update password
                              // This is where you would handle updating the password

                              dynamic PhoneNumber = NewPasswordController.text;
                              phoneController.clear();

                              if (PhoneNumber != null) {
                                // Update the phone
                                FirebaseAuth.instance.currentUser!
                                    .updatePhoneNumber(PhoneNumber);
                                // Update the password in the database

                                FirebaseFirestore.instance
                                    .collection("user")
                                    .doc(FirebaseAuth
                                        .instance.currentUser!.email)
                                    .update({"Phone Number": PhoneNumber});

                                // Show a SnackBar message
                                setState(() {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Phone Number have been updated."),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors
                                          .red, // Set the behavior to floating
                                    ),
                                  );
                                });

                                Navigator.of(context).pop();
                              } else {
                                setState(() {
                                  // Show an error message using SnackBar
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Phone Number not updated. Please try again."),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors
                                          .red, // Set the behavior to floating
                                    ),
                                  );
                                });
                              }
                            },
                            child: Text('Update'),
                          ),
                        ],
                      );
                    },
                  );

// show dialog end
                },
                child: Text(
                  "\t\t\t\t Change Phone Number",
                  style: TextStyle(
                      fontFamily: 'Profile',
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Row(
            children: [
              SizedBox(width: 10.0),
              Text(
                "4 . Do you want to change your Password?",
                style: TextStyle(
                    fontFamily: 'Profile',
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 10.0),
              GestureDetector(
                onTap: () {
                  // Show the dialog

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Change Password'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'After changing the password, you will be logged out. You will have to login again.',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 20),
                            TextField(
                              controller: NewPasswordController,
                              decoration:
                                  InputDecoration(labelText: 'New Password'),
                            ),
                            TextField(
                              controller: ConfirmPasswordController,
                              decoration: InputDecoration(
                                  labelText: 'Confirm Password'),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Close'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Add functionality to update password
                              // This is where you would handle updating the password

                              final String newPassword =
                                  NewPasswordController.text;
                              final String confirmPassword =
                                  ConfirmPasswordController.text;

                              emailController.clear();
                              NewPasswordController.clear();
                              ConfirmPasswordController.clear();

                              if (newPassword == confirmPassword) {
                                // Update the password
                                FirebaseAuth.instance.currentUser!
                                    .updatePassword(newPassword);
                                // Update the password in the database
                                FirebaseFirestore.instance
                                    .collection("user")
                                    .doc(FirebaseAuth
                                        .instance.currentUser!.email)
                                    .update({"Password": newPassword});
                                // Sign out the user
                                FirebaseAuth.instance.signOut().then((value) =>
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Loginpage())));

                                // Show a SnackBar message
                                setState(() {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Passwords have been updated. Please login again."),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors
                                          .red, // Set the behavior to floating
                                    ),
                                  );
                                });

                                Navigator.of(context).pop();
                              } else {
                                setState(() {
                                  // Show an error message using SnackBar
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Passwords do not match. Please try again."),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors
                                          .red, // Set the behavior to floating
                                    ),
                                  );
                                });
                              }
                            },
                            child: Text('Update'),
                          ),
                        ],
                      );
                    },
                  );
                  // show the dialog end
                },
                child: Text(
                  "\t\t\t\t Change Password",
                  style: TextStyle(
                      fontFamily: 'Profile',
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
