class UpdateUserRequest {
  String? username;
  String? password;
  String? email;
  String? gender;
  String? address;
  String? pincode;
  String? description;
  String? state;
  String? mobileNumber;

  UpdateUserRequest({
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

  // Factory method to create an instance from JSON
  factory UpdateUserRequest.fromJson(Map<String, dynamic> json) {
    return UpdateUserRequest(
      username: json['username'],
      password: json['password'],
      email: json['email'],
      gender: json['gender'],
      address: json['address'],
      pincode: json['pincode'],
      description: json['description'],
      state: json['state'],
      mobileNumber: json['mobileNumber'],
    );
  }

  // Method to convert an instance to JSON
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
}
