class Userreqeustmodle {
  String? id;
  String? username;
  String? password;
  String? email;
  String? gender;
  String? address;
  String? pincode;
  String? description;
  String? state;
  String? mobileNumber;
  String? version;

  Userreqeustmodle({
    this.id,
    this.username,
    this.password,
    this.email,
    this.gender,
    this.address,
    this.pincode,
    this.description,
    this.state,
    this.mobileNumber,
    this.version,
  });

  // Factory constructor to create a Userreqeustmodle instance from JSON
  factory Userreqeustmodle.fromJson(Map<String, dynamic> json) {
    return Userreqeustmodle(
      id: json["_id"]?.toString(),
      username: json['username']?.toString(),
      password: json['password']?.toString(),
      email: json['email']?.toString(),
      gender: json['gender']?.toString(),
      address: json['address']?.toString(),
      pincode: json['pincode']?.toString(),
      description: json['description']?.toString(),
      state: json['state']?.toString(),
      mobileNumber: json['mobileNumber']?.toString(),
      version: json["__v"]?.toString(),
    );
  }

  // Method to convert a Userreqeustmodle instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'email': email,
      'gender': gender,
      'address': address,
      'pincode': pincode,
      'description': description,
      'state': state,
      'mobileNumber': mobileNumber,
      '__v': version,
    };
  }
}
