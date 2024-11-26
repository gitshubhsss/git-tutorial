import 'dart:convert';

import 'package:firebase_connection/model/requestModel/UserReqeustModle.dart';
import 'package:get/get.dart';

class Updateuserprovider extends GetConnect {
  Future<Userreqeustmodle?> updateUser(Map<String, dynamic> userData) async {
    print("update user ko call kiya hai");
    String? updateUrl = "http://192.168.164.10:8080/update";
    try {
      final response = await put(updateUrl, userData);

      print(response.statusCode);
      print("printing the response statuscode");
      if (response.statusCode == 200) {
        final body = response.body;
        print(body);
        print("printing the response body");
        return Userreqeustmodle.fromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
