// ignore_for_file: non_constant_identifier_names, unused_local_variable, prefer_const_constructors, avoid_print, use_build_context_synchronously, unused_catch_clause, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, unnecessary_brace_in_string_interps, prefer_final_fields

import 'package:flutter/material.dart';

Widget Loading() {
  return Padding(
    padding: const EdgeInsets.all(50.0),
    child: Center(
      child: Container(
          height: 120,
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: Colors.blue[100], borderRadius: BorderRadius.circular(20)),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Data Processing...",
                      style: TextStyle(fontSize: 20, fontFamily: 'Profile'))
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.blue[200],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
              const SizedBox(height: 20),
            ],
          )),
    ),
  );
}

Widget Alert(String message) {
  return Center(
    child: Container(
        height: 120,
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: Colors.red[100], borderRadius: BorderRadius.circular(20)),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(message,
                    style: const TextStyle(fontSize: 20, fontFamily: 'Profile'))
              ],
            ),
          ],
        )),
  );
}
