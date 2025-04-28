import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth import
import 'package:vishayam/authentication/login1.dart'; // Path to login screen
import 'package:vishayam/home/homepage.dart'; // Path to home screen

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(), // Auth state changes stream
      builder: (context, snapshot) {
        // If Firebase is still checking the auth state, show a loading indicator
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // If the user is authenticated, show the HomeFolderScreen
        if (snapshot.hasData) {
          return const HomeFolderScreen();
        }

        // If the user is not authenticated, always show the Login screen
        return const loginscreen();
      },
    );
  }
}
