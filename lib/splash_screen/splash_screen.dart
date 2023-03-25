import 'dart:async';

import 'package:ami_milk/AGENT%20PAGES/homePage/homePage.dart';
import 'package:ami_milk/Distributor_login_signup/login.dart';
import 'package:ami_milk/fetch_from_firebase/provaider/horiItemProvaider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Home Page/mainHomeDesign.dart';
import '../fetch_from_firebase/provaider/homeItemProvaider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static const String KEYLOGIN = "login";
  static const String KEYAGENTLOGIN = "agentLogin";
  @override
  void initState() {
    // TODO: implement initState
    changeScreen();

    super.initState();
  }

  changeScreen() async {
    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool(KEYLOGIN);
    var isAgentLoggedIn = sharedPref.getBool(KEYAGENTLOGIN);

    Timer(Duration(seconds: 2), () {
      if (isLoggedIn != null) {
        if (isLoggedIn) {
          if (isAgentLoggedIn == true) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => agentHome()));
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => mainHomePageDesign()),
            );
          }
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyLogin(),
            ),
          );
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyLogin(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          'assets/splashScreen.gif',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
