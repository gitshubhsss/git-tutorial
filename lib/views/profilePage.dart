import 'dart:convert';

import 'package:firebase_connection/controllers/mainController.dart';
import 'package:firebase_connection/model/requestModel/UserReqeustModle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Logincontroller controller = Get.put(Logincontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("User Profile"),
        ),
      ),
      body: Column(
        children: [
          Icon(
            Icons.person,
            size: 100,
          ),
          SizedBox(height: 20),
          Center(child: Obx(() {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: ListTile(
                    title: Text('Name'),
                    subtitle: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: controller.userreqeustmodle.value.username,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: ListTile(
                    title: Text('Email'),
                    subtitle: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: controller.userreqeustmodle.value.email ?? "",
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: ListTile(
                    title: Text('Mobile'),
                    subtitle: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText:
                            controller.userreqeustmodle.value.mobileNumber,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: ListTile(
                    title: Text('Address'),
                    subtitle: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText:
                            controller.userreqeustmodle.value.address ?? "",
                      ),
                    ),
                  ),
                ),
              ],
            );
          })),
          SizedBox(height: 20),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.orange),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                ),
              ),
            ),
            onPressed: () {
              // Navigate to update profile page
              Get.toNamed("/updateProfile");
            },
            child: Text(
              "Update Profile",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
