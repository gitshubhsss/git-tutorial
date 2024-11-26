import 'package:firebase_connection/model/requestModel/UserReqeustModle.dart';

class Loginrequestmodel {
  final String message;
  final String token;
  final Userreqeustmodle user;

  Loginrequestmodel({
    required this.message,
    required this.token,
    required this.user,
  });

  // Factory constructor to create a Loginrequestmodel instance from JSON
  factory Loginrequestmodel.fromJson(Map<String, dynamic> json) {
    return Loginrequestmodel(
      message: json['message'] as String,
      token: json['token'] as String,
      user: Userreqeustmodle.fromJson(json['user']),
    );
  }

  // Method to convert a Loginrequestmodel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'token': token,
      'user': user.toJson(),
    };
  }
}
