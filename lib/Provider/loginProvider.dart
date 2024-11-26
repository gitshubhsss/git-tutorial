import 'dart:convert';

import 'package:firebase_connection/model/requestModel/UserReqeustModle.dart';
import 'package:firebase_connection/model/requestModel/loginRequestModel.dart';
import 'package:firebase_connection/model/responseModel/LoginResponseModel.dart';
import 'package:get/get.dart';

class Loginprovider extends GetConnect {
  Future<Loginrequestmodel?> login(
      LoginResponseModel loginresponsemodel) async {
    //Map<String, dynamic>>  this is the return type
    String url = "http://192.168.164.10:8080/login";
    try {
      final response =
          await post(url, jsonEncode(loginresponsemodel), headers: {
        'Content-Type': 'application/json',
      });
      print("Printing status code of response: ${response.statusCode}");

      if (response.statusCode == 200) {
        print(response.body);
        print("printing the body");
        final body = response.body;
        print("statuscode is 200");
        
        return Loginrequestmodel.fromJson(response.body);
      } else {
        Get.snackbar('Error', 'Error in login');

        return null;
      }
    } catch (e) {
      Get.snackbar('Error', 'Error in login');

      return null;
    }
  }
}
