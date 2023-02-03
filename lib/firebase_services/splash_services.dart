import 'dart:async';

import 'package:firebase/ui/auth/login_screen.dart';
import 'package:firebase/ui/splash_screen.dart';
import 'package:flutter/material.dart';

class SplashServices {

  void isLogin(BuildContext context){

   Timer(Duration(seconds: 3), () {
     Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(),));
   });
  }

}