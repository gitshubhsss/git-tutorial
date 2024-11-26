  class SignupResponseModel {
    String? username;
    String? password;
    String? email;
    String? gender;
    String? address;
    String? pincode;
    String? description;
    String? state;
    String? mobileNumber;

    SignupResponseModel({
      this.username,
      this.password,
      this.email,
      this.gender,
      this.address,
      this.pincode,
      this.description,
      this.state,
      this.mobileNumber,
    });

    // Factory method for creating an instance from JSON
    factory SignupResponseModel.fromJson(Map<String, dynamic> json) {
      return SignupResponseModel(
        username: json['username'] ?? '',
        password: json['password'] ?? '',
        email: json['email'],
        gender: json['gender'] ?? '',
        address: json['address'] ?? '',
        pincode: json['pincode'] ?? '',
        description: json['description'],
        state: json['state'] ?? '',
        mobileNumber: json['mobileNumber'] ?? '',
      );
    }

    // Method for converting an instance to JSON
    Map<String, dynamic> toJson() {
      return {
        'username': username,
        'password': password,
        'email': email,
        'gender': gender,
        'address': address,
        'pincode': pincode,
        'description': description,
        'state': state,
        'mobileNumber': mobileNumber,
      };
    }

    // Validation function
    Map<String, String?> validate() {
      final Map<String, String?> errors = {};

      // Validate username
      if (username!.isEmpty) {
        errors['username'] = 'Username is required';
      }

      // Validate password (at least 6 characters)
      if (password!.isEmpty) {
        errors['password'] = 'Password is required';
      } else if (password!.length < 6) {
        errors['password'] = 'Password must be at least 6 characters';
      }

      // Validate email (optional but must be a valid format if provided)
      final emailRegex =
          RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
      if (email != null && email!.isNotEmpty && !emailRegex.hasMatch(email!)) {
        errors['email'] = 'Enter a valid email address';
      }

      // Validate gender (non-empty)
      if (gender!.isEmpty) {
        errors['gender'] = 'Gender is required';
      }

      // Validate address (non-empty)
      if (address!.isEmpty) {
        errors['address'] = 'Address is required';
      }

      // Validate pincode (6 digits)
      final pincodeRegex = RegExp(r'^\d{6}$');
      if (pincode!.isEmpty) {
        errors['pincode'] = 'Pincode is required';
      } else if (!pincodeRegex.hasMatch(pincode!)) {
        errors['pincode'] = 'Enter a valid 6-digit pincode';
      }

      // Validate description (optional, max 200 characters if provided)
      if (description != null && description!.length > 200) {
        errors['description'] = 'Description should not exceed 200 characters';
      }

      // Validate state (non-empty)
      if (state!.isEmpty) {
        errors['state'] = 'State is required';
      }

      // Validate mobile number (10 digits)
      final mobileRegex = RegExp(r'^\d{10}$');
      if (mobileNumber!.isEmpty) {
        errors['mobileNumber'] = 'Mobile number is required';
      } else if (!mobileRegex.hasMatch(mobileNumber!)) {
        errors['mobileNumber'] = 'Enter a valid 10-digit mobile number';
      }

      return errors;
    }
  }
