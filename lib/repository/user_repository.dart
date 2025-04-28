import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vishayam/auth/models/usermodel.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create a new user in Firestore
  Future<void> createUser(UserModel user) async {
    try {
      // Convert user model to a map before adding to Firestore
      await _db.collection("Users").add(user.toMap());
    } catch (e) {
      throw Exception("Failed to create user: $e");
    }
  }
}
