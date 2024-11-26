import 'dart:convert';
import 'package:firebase_connection/controllers/logoutController.dart';
import 'package:firebase_connection/controllers/mainController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Homepage extends StatefulWidget {
  const Homepage({super.key});
  @override
  State<Homepage> createState() => _HomepageState();
}


class _HomepageState extends State<Homepage> {
  final LogoutController logoutController = Get.put(LogoutController());
  final Logincontroller logincontroller = Get.put(Logincontroller());

  Future<bool> _onWillPop() async {
    bool shouldExit = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit'),
        content: Text('Are you sure you want to exit and log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Yes'),
          ),
        ],
      ),
    );

    if (shouldExit == true) {
      await logoutController.logout(); // Clear data in SharedPreferences
      Get.snackbar("Logout", "You have been logged out"); // Optional snackbar
      Get.offAllNamed(
          '/login'); // Navigate to login screen and clear navigation stack
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Center(child: Text("Hello")),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await logoutController.logout();
                Get.snackbar("Logout", "You have been logged out");
                Get.toNamed('/login');
              },
            ),
          ],
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed("/profile");
              },
              child: Text('View Profile'),
            ),
          ),
        ),
      ),
    );
  }
}
