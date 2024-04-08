import 'package:codeblock/pages/page_navi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmailVerificationChecker extends StatefulWidget {
  const EmailVerificationChecker({super.key});

  @override
  State<EmailVerificationChecker> createState() =>
      _EmailVerificationCheckerState();
}

class _EmailVerificationCheckerState extends State<EmailVerificationChecker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (FirebaseAuth.instance.currentUser!.emailVerified)
          ? const HomeScreen()
          : Center(child: Lottie.asset("assets/mp4/email.json")),
    );
  }
}
