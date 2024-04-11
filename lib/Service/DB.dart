// ignore_for_file: file_names, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore DB = FirebaseFirestore.instance;
// Add Post
  Future<void> AddPost(String title, String description) async {
    // store post data in database
    await DB.collection('Posts').add({
      'Topic': title,
      'Description': description,
      'Post By': auth.currentUser!.email,
      'Time': DateTime.now(),
    });
  }

// Delete Post
  Future<void> DeletePost() async {
    // delete post from database
    final ID = auth.currentUser!.uid;
    await DB.collection('Posts').doc(ID).delete();
  }

//Update Post
  Future<void> UpdatePost(String title, String description) async {
    // update post in database
    final ID = auth.currentUser!.email;
    await DB.collection('Posts').doc(ID).update({
      'Topic': title,
      'Description': description,
      'Post By': ID,
      'Time': DateTime.now(),
    });
  }
}
