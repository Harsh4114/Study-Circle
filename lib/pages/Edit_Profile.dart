// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unnecessary_brace_in_string_interps, use_build_context_synchronously, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, sort_child_properties_last, camel_case_types, file_names

import 'package:flutter/material.dart';

class Edit_Profile extends StatefulWidget {
  const Edit_Profile({super.key});

  @override
  State<Edit_Profile> createState() => _Edit_ProfileState();
}

class _Edit_ProfileState extends State<Edit_Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'This is the Edit Profile page',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
