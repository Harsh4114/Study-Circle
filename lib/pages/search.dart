// ignore_for_file: unused_local_variable, unused_catch_clause, prefer_const_constructors, avoid_print, deprecated_member_use, non_constant_identifier_names, camel_case_types, prefer_final_fields, unused_field, use_key_in_widget_constructors, use_build_context_synchronously, file_names, library_private_types_in_public_api
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Perform search logic here
                print('Searching for: $_searchQuery');
              },
              child: Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}
