import 'dart:convert';
import 'package:get/get.dart';

class Signupprovider extends GetConnect {
  Future<bool> signup(signupdata) async {
    print("Inside the provider");
    print(signupdata);
    String url = "http://192.168.164.10:8080/signup";
    try {
      // Specify headers for the request
      final response = await post(
        url,
        signupdata,
        headers: {
          'Content-Type': 'application/json', // Set content type
        },
      );

      print("Printing status code of response: ${response.statusCode}");

      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Signup successful!');
        return true;
      } else {
        Get.snackbar('Error', 'Signup failed: ${response.body}');
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
    print("Returning false");
    return false;
  }
}
