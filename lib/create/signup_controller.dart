import 'package:firebase_auth/firebase_auth.dart'; // Firebase Authentication
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore
import 'package:vishayam/auth/models/usermodel.dart'; // UserModel for Firestore

class SignupController {
  final FirebaseAuth _auth = FirebaseAuth.instance; // FirebaseAuth instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Firestore instance

  // Register the user and store additional data in Firestore
  Future<String?> registerUser({
    required String username,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      // Create user with Firebase Auth
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the newly created user
      User? user = userCredential.user;

      // Create a new UserModel with additional information
      UserModel newUser = UserModel(
        uid: user!.uid,
        username: username,
        email: email,
        phoneNumber: phoneNumber,
      );

      // Store the user data in Firestore under the 'users' collection
      await _firestore.collection('users').doc(user.uid).set(newUser.toMap());

      // Return null to indicate success
      return null;
    } on FirebaseAuthException catch (e) {
      // Return the error message to the caller
      return e.message;
    } catch (e) {
      // Handle other errors (Firestore errors, etc.)
      return "An unknown error occurred.";
    }
  }
}
