import 'dart:convert';

import 'package:firebase_connection/auth/SignUp_page.dart';
import 'package:firebase_connection/auth/auth_funtion.dart';
import 'package:firebase_connection/controllers/mainController.dart';
import 'package:firebase_connection/model/responseModel/LoginResponseModel.dart';
import 'package:firebase_connection/model/responseModel/signup_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  bool isLogin = false;

  Logincontroller controller = Get.put(Logincontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Center(child: Text(' Login')),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    maxLength: 10,
                    keyboardType: TextInputType.numberWithOptions(),
                    onChanged: (value) {
                      controller.loginResponseModel.value.mobileNumber =
                          value.toString();
                    },
                    decoration: InputDecoration(
                        hintText: 'Enter your mobile number',
                        label: Text('Mobile '),
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value.toString().length < 10) {
                        return 'Mobile number is to small';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(() {
                    return TextFormField(
                      key: ValueKey('password'), //we have defined the key
                      validator: (value) {
                        if (value.toString().length < 6) {
                          return 'Password is too small';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        controller.loginResponseModel.value.password =
                            value.toString();
                      },
                      obscureText: controller.obsecure.value,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('password'),
                          hintText: 'Enter the password',
                          suffixIcon: InkWell(
                              onTap: () {
                                controller.obsecure.value == false
                                    ? controller.obsecure.value = true
                                    : controller.obsecure.value = false;
                              },
                              child: Icon(controller.obsecure.value == true
                                  ? Icons.remove_red_eye
                                  : Icons.visibility_off))),
                    );
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.orange),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(10, 10))))),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          print("printing the controllers data");
                          print(controller.loginResponseModel.value.toJson());
                          print(jsonEncode(controller.loginResponseModel.value.toJson()));

                          
                          // print("jsondeconde");
                          // print(jsonDecode(controller.loginResponseModel.value
                          //     .toJson()
                          //     .toString()));
                          // print('json encode');
                          // print(jsonEncode(
                          //     controller.loginResponseModel.value.toJson()));
                          await controller
                              .login(controller.loginResponseModel.value);
                         
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        //give the path of signup page
                        Get.toNamed("/signup");
                      },
                      child: Text('dont have an accont ? Signup '))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
