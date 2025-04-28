class UserModel {
  String? uid;
  String? username;
  String? email;
  String? phoneNumber;

  UserModel({this.uid, this.username, this.email, this.phoneNumber});

  // Convert a UserModel into a Map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  // Create a UserModel from a Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      username: map['username'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
    );
  }
}
