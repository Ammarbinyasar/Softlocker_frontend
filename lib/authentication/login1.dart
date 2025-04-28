import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth import
import 'package:vishayam/authentication/forgotopassword.dart';
import 'package:vishayam/create/register.dart';

final _formkey = GlobalKey<FormState>();

class loginscreen extends StatefulWidget {
  const loginscreen({super.key});

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email cannot be empty';
    }
    if (!email.contains('@')) {
      return 'Email must contain "@" symbol';
    }
    RegExp emailRegex = RegExp(r'^[\w.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password cannot be empty';
    }
    if (password.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  // Firebase login function
  Future<void> signIn() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailcontroller.text.trim(),
          password: _passwordcontroller.text.trim(),
        );
        // Navigate to home after successful login
        Navigator.pushReplacementNamed(context, '/home');
      } on FirebaseAuthException catch (e) {
        setState(() {
          _errorMessage = e.message;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30),
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0x00ffffff).withOpacity(1.0),
                  const Color(0x00999999).withOpacity(1.0)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: double.infinity,
              height: 620,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0x0092e1e2).withOpacity(1.0),
                    const Color(0x000d4671).withOpacity(1.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(190),
                  bottomRight: Radius.circular(190),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Column(
                children: [
                  Image.asset(
                    'assets/login/logo.png',
                    width: 95,
                    height: 79,
                  ),
                  const SizedBox(height: 20),
                  GradientText(
                    'SoftLocker',
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.w600),
                    colors: [
                      const Color(0x002b2a7b).withOpacity(1.0),
                      const Color(0x000071a5).withOpacity(1.0),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Container(
                    alignment: Alignment.center,
                    width: 348,
                    height: 397,
                    decoration: BoxDecoration(
                      color: const Color(0x00e7ebeb).withOpacity(1.0),
                      borderRadius: BorderRadius.circular(62),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 0, 0, 0)
                              .withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 7.1,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          'LOGIN',
                          style: const TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w500,
                            color: Color(0x00273b4a),
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Form
                        Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              // Email
                              Container(
                                alignment: Alignment.center,
                                width: 314,
                                height: 56,
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0x000d4671).withOpacity(1.0),
                                  borderRadius: BorderRadius.circular(19),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        width: 275,
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                          color: const Color(0x00fff5f5)
                                              .withOpacity(1.0),
                                          borderRadius:
                                              BorderRadius.circular(19),
                                        ),
                                        child: TextFormField(
                                          controller: _emailcontroller,
                                          validator: validateEmail,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          decoration: const InputDecoration(
                                            hintText: 'Enter your email',
                                            hintStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 129, 129, 129),
                                            ),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                          ),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
                                          ),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: SvgPicture.asset(
                                          'assets/login/email.svg',
                                          height: 24,
                                          width: 24,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                              // Password
                              Container(
                                alignment: Alignment.center,
                                width: 314,
                                height: 56,
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0x000d4671).withOpacity(1.0),
                                  borderRadius: BorderRadius.circular(19),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        width: 275,
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                          color: const Color(0x00fff5f5)
                                              .withOpacity(1.0),
                                          borderRadius:
                                              BorderRadius.circular(19),
                                        ),
                                        child: TextFormField(
                                          controller: _passwordcontroller,
                                          validator: validatePassword,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          obscureText: true,
                                          decoration: const InputDecoration(
                                            hintText: 'Enter your Password',
                                            hintStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 129, 129, 129),
                                            ),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                          ),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
                                          ),
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: SvgPicture.asset(
                                          'assets/login/pass.svg',
                                          height: 24,
                                          width: 24,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              // Forgot Password Button
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => forgott()),
                                    );
                                  },
                                  child: const Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              // Login Button
                              _isLoading
                                  ? const CircularProgressIndicator()
                                  : ElevatedButton(
                                      onPressed: () {
                                        signIn(); // Call signIn on login
                                      },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: const Color(0x00ffffff)
                                            .withOpacity(1.0),
                                        backgroundColor:
                                            const Color(0x000d4671)
                                                .withOpacity(1.0),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 50, vertical: 20),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(19),
                                        ),
                                      ),
                                      child: const Text('Login'),
                                    ),
                              if (_errorMessage != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    _errorMessage!,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Divider(
                          thickness: 2,
                          indent: 32,
                          endIndent: 8,
                          color: Colors.black,
                        ),
                      ),
                      const Text(
                        'Or Login with',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const Expanded(
                        child: Divider(
                          thickness: 2,
                          indent: 8,
                          endIndent: 32,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset('assets/login/google.png'),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: const TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Register Now',
                            style: TextStyle(
                              color: const Color(0x000071a5).withOpacity(1.0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
