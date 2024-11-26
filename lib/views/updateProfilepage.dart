import 'package:firebase_connection/Contansts/enums/StateEnums.dart';
import 'package:firebase_connection/Contansts/enums/genderEnum.dart';
import 'package:firebase_connection/controllers/mainController.dart';
import 'package:firebase_connection/model/requestModel/updateUserRequest_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  UpdateUserRequest updateuser = UpdateUserRequest();
  final _formKey = GlobalKey<FormState>();

  Gender? selectedGender;

  Logincontroller controller = Get.put(Logincontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Center(
          child: Text("Update profile"),
        ),
      ),
      body: Container(
        child: Center(
          child: Container(
            margin: EdgeInsets.all(20),
            child: SingleChildScrollView(
                child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      // Set initial value from the database
                      initialValue:
                          controller.userreqeustmodle.value.username != null
                              ? controller.userreqeustmodle.value.username
                              : null,

                      // Update `updateuser.username` on field creation if initialValue is not null
                      onChanged: (value) {
                        updateuser.username = value.toString();
                      },

                      // Validator to check if the field is empty
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Username can't be empty";
                        }
                        return null;
                      },

                      // Decoration for the input field
                      decoration: InputDecoration(border: OutlineInputBorder()),

                      // Trigger `updateuser.username` with initial value if it exists
                      onSaved: (value) {
                        updateuser.username =
                            value != null ? value : updateuser.username;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      initialValue:
                          controller.userreqeustmodle.value.email ?? null,
                      onChanged: (value) {
                        updateuser.email = value.toString();
                      },
                      onSaved: (value) {
                        updateuser.email =
                            value ?? controller.userreqeustmodle.value.email;
                      },
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          // Regular expression for basic email validation
                          final emailRegExp =
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (!emailRegExp.hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      initialValue:
                          controller.userreqeustmodle.value.mobileNumber!,
                      onSaved: (value) {
                        updateuser.mobileNumber =
                            value ?? updateuser.mobileNumber;
                      },
                      onChanged: (value) {
                        updateuser.mobileNumber = value.toString();
                      },
                      keyboardType: TextInputType.numberWithOptions(),
                      readOnly: true,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors
                            .transparent, // Set background color to transparent
                        border: Border.all(
                            color: Colors
                                .grey), // Optional: add border for visibility
                        borderRadius: BorderRadius.circular(
                            5), // Optional: rounded corners
                      ),
                      child: DropdownButtonFormField<Gender>(
                        isExpanded: true,
                        value: controller.parseGender(controller
                                .userreqeustmodle!.value.gender
                                .toString()) ??
                            controller.selectedGender.value,
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a gender';
                          }
                          return null;
                        },
                        onSaved: (Gender? gender) {
                          updateuser.gender = gender.toString().split('.').last;
                        },
                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text("Select Gender"),
                        ),
                        items: Gender.values.map((Gender gender) {
                          return DropdownMenuItem(
                            value: gender,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                gender.toString().split('.').last.toUpperCase(),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (Gender? value) {
                          controller.updateGender(value);
                          print(controller.selectedGender.value);
                          print("printing hte value");
                          updateuser.gender = value?.toString().split('.').last;
                        },
                      ),
                    );
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: TextFormField(
                      maxLength: 6,
                      initialValue: controller
                                  .userreqeustmodle.value.pincode?.isNotEmpty ==
                              true
                          ? controller.userreqeustmodle.value.pincode
                          : null,
                      keyboardType: TextInputType.numberWithOptions(),
                      onChanged: (value) {
                        updateuser.pincode = value.toString();
                      },
                      validator: (value) {
                        if (value.toString().length < 6) {
                          return " picode must be of 6 digits";
                        }
                      },
                      onSaved: (value) {
                        updateuser.pincode =
                            value ?? controller.userreqeustmodle.value.pincode;
                      },
                      decoration: InputDecoration(
                          hintText: 'Pincode', border: OutlineInputBorder()),
                    ),
                  ),
                  Container(
                    child: TextFormField(
                      initialValue: controller
                                  .userreqeustmodle.value.description
                                  .toString()
                                  .isNotEmpty ==
                              true
                          ? controller.userreqeustmodle.value.description
                          : null,
                      onChanged: (value) {
                        updateuser.description = value.toString();
                      },
                      onSaved: (newValue) {
                        updateuser.description = newValue ??
                            controller.userreqeustmodle.value.description;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Descripiton',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: TextFormField(
                      initialValue: controller
                                  .userreqeustmodle.value.address
                                  .toString()
                                  .isNotEmpty ==
                              true
                          ? controller.userreqeustmodle.value.address
                          : null,
                      onChanged: (value) {
                        updateuser.address = value.toString();
                      },
                      onSaved: (value) {
                        updateuser.address =
                            value ?? controller.userreqeustmodle.value.address;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: 'address'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
                    child: DropdownButtonFormField<Stateenums>(
                      isExpanded: true,
                      value: controller.parseState(controller
                              .userreqeustmodle.value.state
                              .toString()) ??
                          controller.selectedState.value,
                      hint: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text("Select State "),
                      ),
                      onSaved: (Stateenums? state) {
                        updateuser.state = state.toString().split('.').last;
                      },
                      items: Stateenums.values.map((Stateenums state) {
                        return DropdownMenuItem(
                          value: state,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              state.toString().split('.').last.toUpperCase(),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (Stateenums? value) {
                        controller.updateState(value);
                        print(value);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(width:10),//deature 2
                  SizedBox(child: Text("khikjijkji"),),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.orange)),
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState!.save();

                          var isUpdate =
                              await controller.updateUser(updateuser.toJson());
                          if (isUpdate) {
                            Get.toNamed("/profile");
                            Get.snackbar("Update", "UpdatedSuccessrully");
                          } else {
                            Get.snackbar("Error", "Nahi ho payega");
                          }
                        } else {
                          print("Form is invalid");
                        }
                      },
                      child: Text(
                        'Update profile',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}
