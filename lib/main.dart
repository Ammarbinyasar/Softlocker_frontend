import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'wrapper.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBxZMNKpM4B3RYEHenqe2L6H5oBVPkKdTc",
            authDomain: "softlocker-a224b.firebaseapp.com",
            projectId: "softlocker-a224b",
            storageBucket: "softlocker-a224b.firebasestorage.app",
            messagingSenderId: "978579679610",
            appId: "1:978579679610:web:568d94bb75f617006e8ec3"));
    runApp(const MyApp());
  } else {
    Firebase.initializeApp();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Softlocker',
      home: Wrapper(),
    );
  }
}
