import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_final_exam/view/helper/google_services.dart';
import 'package:flutter_final_exam/view/screen/home/home_page.dart';
import 'package:flutter_final_exam/view/screen/sign/sign_in.dart';

import '../../../utils/color.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GoogleServices.googleServices.firebaseAuth.currentUser==null?SigninScreen():HomePage(),));
    },);
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child:  Icon(
          Icons.edit_note,
          color: primaryColor,
          size: 150,
        ),
      ),
    );
  }
}
