import 'dart:async';
import 'dart:convert';
import 'package:firebase_connection/auth/Login_page.dart';
import 'package:firebase_connection/controllers/mainController.dart';
import 'package:firebase_connection/model/requestModel/UserReqeustModle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart'; // Replace with the actual path to Homepage

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  Logincontroller controller = Get.put(Logincontroller());

  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      gotoWhichOne();
    });

    super.initState();
  }

  void gotoWhichOne() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userJson = preferences.getString('user');
    print(userJson.toString());
    print(preferences.containsKey('user'));
    print("inside the preffrece");
    if (preferences.containsKey('user')) {
      String? userJson = preferences.getString('user');
      if (userJson != null) {
        controller.userreqeustmodle.value =
            Userreqeustmodle.fromJson(jsonDecode(userJson.toString()));
        Get.toNamed("/home");
      }
    } else {
      Get.toNamed("/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.flash_on,
              color: Colors.white,
              size: 100,
            ),
            SizedBox(height: 20),
            Text(
              "Welcome!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
