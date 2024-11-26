class LoginResponseModel {
  String? mobileNumber;
  String? password;

  LoginResponseModel({
    this.mobileNumber,
    this.password,
  });

  // Factory method for creating an instance from JSON
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      mobileNumber: json['mobileNumber'] ?? '',
      password: json['password'] ?? '',
    );
  }

  // Method for converting an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'mobileNumber': mobileNumber,
      'password': password,
    };
  }

  // Validation function
  Map<String, String?> validate() {
    final Map<String, String?> errors = {};
    // Validate mobile number (10 digits)
    final mobileRegex = RegExp(r'^\d{10}$');
    if (mobileNumber!.isEmpty) {
      errors['mobileNumber'] = 'Mobile number is required';
    } else if (!mobileRegex.hasMatch(mobileNumber!)) {
      errors['mobileNumber'] = 'Enter a valid 10-digit mobile number';
    }

    // Validate password (at least 6 characters)
    if (password!.isEmpty) {
      errors['password'] = 'Password is required';
    } else if (password!.length < 6) {
      errors['password'] = 'Password must be at least 6 characters';
    }
    return errors;
  }
}
