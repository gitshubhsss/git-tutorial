import 'dart:convert';

import 'package:firebase_connection/Contansts/enums/StateEnums.dart';
import 'package:firebase_connection/Contansts/enums/genderEnum.dart';
import 'package:firebase_connection/Provider/UpdateUserProvider.dart';
import 'package:firebase_connection/Provider/loginProvider.dart';
import 'package:firebase_connection/model/requestModel/UserReqeustModle.dart';
import 'package:firebase_connection/model/requestModel/loginRequestModel.dart';
import 'package:firebase_connection/model/responseModel/LoginResponseModel.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logincontroller extends GetxController {
  Future<void> saveUser(userreqeustmodle) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'user',
        jsonEncode(
            userreqeustmodle)); //in the form of json am storing the information
  }

  final Loginprovider loginprovider = Loginprovider();
  final obsecure = true.obs;

  String? token = "";
  String? message = "";
  var isLogin = false.obs;

  var loginResponseModel = LoginResponseModel().obs;
  var user = [].obs;
  late Loginrequestmodel loginrequestmodel;
  var userreqeustmodle = Userreqeustmodle().obs;

  var islog = false.obs;

  Future<bool> login(loginresponsemodel) async {
    try {
      final response = await loginprovider.login(loginresponsemodel);

      if (response != null && response.message == "Login successful") {
        loginrequestmodel = Loginrequestmodel(
            message: response.message,
            token: response.token,
            user: response.user);
        userreqeustmodle.value =
            Userreqeustmodle.fromJson(jsonDecode(response.user.toString()));

        print(userreqeustmodle.value.address);
        print("printign the address");
        savetoken(loginrequestmodel.token);
        saveUser(userreqeustmodle);
        Get.toNamed('/home');
      } else {
        Get.snackbar("Error", 'Nahi ho payega login');
        isLogin.value = false;
      }
      return isLogin.value;
    } catch (e) {
      return isLogin.value;
    }
  }

  // Save token in SharedPreferences
  Future<void> savetoken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  // Retrieve token from SharedPreferences
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  var selectedGender = Rxn<Gender>(); // Using Rxn for nullable type

  void updateGender(Gender? value) {
    selectedGender.value = value;
  }

  Gender? parseGender(String? gender) {
    if (gender == null) return null;
    return Gender.values.firstWhere(
      (e) => e.toString().split('.').last == gender.toLowerCase(),
      orElse: () => Gender.male,
    );
  }

  var selectedState = Rxn<Stateenums>();

  void updateState(Stateenums? state) {
    selectedState.value = state;
  }

  Stateenums? parseState(String? state) {
    if (state == null) return null;

    // Create a map to convert strings to enum values
    final stateMap = {
      'Maharastra': Stateenums.Maharastra,
      'Delhi': Stateenums.Delhi,
      'Gujarat': Stateenums.Gujrat,
      'Rajstan': Stateenums.Rajstan

      // Add all other states here
    };
    return stateMap[state] ?? Stateenums.Maharastra; // Default if not found
  }

  // --------------------------------------------------update controller-----------------------------------
  Updateuserprovider updateuserprovider = Updateuserprovider();
  var isUpdated = false.obs;

  Future<bool> updateUser(Map<String, dynamic> userData) async {
    final response = await updateuserprovider.updateUser(userData);
    if (response != null) {
      print("response is not null");
      userreqeustmodle.value = Userreqeustmodle.fromJson(response.toJson());
      saveUser(userreqeustmodle.value);
      return true;
    } else {
      print("response null hai");
    }
    return false;
  }
}
