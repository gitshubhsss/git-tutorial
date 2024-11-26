import 'package:firebase_connection/Contansts/enums/genderEnum.dart';
import 'package:firebase_connection/controllers/signupController.dart';
import 'package:firebase_connection/model/responseModel/signup_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  Signupcontroller controller = Get.put(Signupcontroller());
  final SignupResponseModel signupResponseModel = SignupResponseModel();
  Gender? selectedGender; // Track the selected gender

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Center(child: Text('Sign Up')),
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
                  // Full Name TextFormField
                  TextFormField(
                    onChanged: (value) {
                      signupResponseModel.username = value.toString();
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your full name',
                      label: Text("Full Name"),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Full name is empty";
                      }
                      return null; // Return null if valid
                    },
                  ),
                  SizedBox(height: 20),

                  // Mobile Number TextFormField
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    onChanged: (value) {
                      signupResponseModel.mobileNumber = value.toString();
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your mobile number',
                      label: Text("Mobile Number"),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.length < 10) {
                        return "Mobile number must be 10 digits";
                      }
                      return null; // Return null if valid
                    },
                  ),
                  SizedBox(height: 20),

                  // Email TextFormField
                  TextFormField(
                    onChanged: (value) {
                      signupResponseModel.email = value.toString();
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      label: Text("Email"),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      final emailRegex = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                      if (value == null || !emailRegex.hasMatch(value)) {
                        return "Enter a valid email address";
                      }
                      return null; // Return null if valid
                    },
                  ),
                  SizedBox(height: 20),

                  // Gender Dropdown
                  Container(
                    decoration: BoxDecoration(
                      color: Colors
                          .transparent, // Set background color to transparent
                      border: Border.all(
                          color: Colors
                              .grey), // Optional: add border for visibility
                      borderRadius:
                          BorderRadius.circular(5), // Optional: rounded corners
                    ),
                    child: DropdownButton<Gender>(
                      isExpanded: true,
                      value: selectedGender,
                      hint: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text("Select Gender"),
                      ),
                      items: Gender.values.map((Gender gender) {
                        return DropdownMenuItem(
                          value: gender,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              gender.toString().split('.').last.toUpperCase(),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (Gender? value) {
                        setState(() {
                          selectedGender = value;
                          signupResponseModel.gender = value
                              ?.toString()
                              .split('.')
                              .last; // Store gender as a string
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    onChanged: (value) {
                      signupResponseModel.address = value.toString();
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your adress',
                      label: Text("Address"),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Enter your address";
                      }
                      return null; // Return null if valid
                    },
                  ),
                  SizedBox(height: 20),

                  Obx(() {
                    return TextFormField(
                      onChanged: (value) {
                        signupResponseModel.password = value.toString();
                      },
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return "passward is requred";
                        } else {
                          return null;
                        }
                      },
                      obscureText: controller.obsecure.value,
                      decoration: InputDecoration(
                          suffixIcon: InkWell(
                              onTap: () {
                                controller.obsecure.value == false
                                    ? controller.obsecure.value = true
                                    : controller.obsecure.value = false;
                              },
                              child: Icon(controller.obsecure.value == true
                                  ? Icons.remove_red_eye
                                  : Icons.visibility_off)),
                          label: Text('Passward'),
                          border: OutlineInputBorder()),
                    );
                  }),

                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      controller.comformPassword.value = value.toString();
                    },
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "Passward is required";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        label: Text('Comform passward'),
                        border: OutlineInputBorder()),
                  ),
                  // Signup Button
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
                        if (_formKey.currentState!.validate() &&
                            signupResponseModel.password.toString() ==
                                controller.comformPassword.value) {
                          _formKey.currentState!.save();
                          final signupdata = signupResponseModel.toJson();
                          await controller.signup(signupdata);
                          if (controller.isSuccess.value) {
                            print(controller.isSuccess.value);
                            Get.snackbar('Succss', 'SignUp succesfully');
                            Get.toNamed("/login");
                          }
                        } else {
                          Get.snackbar("Error", "Passward does not mathch");
                        }
                      },
                      child: Text(
                        'Signup',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
