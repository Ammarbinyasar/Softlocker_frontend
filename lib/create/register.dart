import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Authentication
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:vishayam/authentication/login1.dart';
// Home screen after onboarding
import 'package:vishayam/onboarding/onboarding.dart'; 

final _formkey = GlobalKey<FormState>();

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _usercontroller = TextEditingController();
  final _phonecontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _confirmpasswordcontroller = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = false; // Loading state
  String? _errorMessage; // Error message state

  // Method to handle registration and Firestore saving
  Future<void> registerUser(BuildContext context) async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        // Create user in Firebase Authentication
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _emailcontroller.text.trim(),
          password: _passwordcontroller.text.trim(),
        );

        // Get the newly created user
        User? user = userCredential.user;

        // Save user details in Firestore
        await _firestore.collection('users').doc(user!.uid).set({
          'uid': user.uid,
          'username': _usercontroller.text.trim(),
          'email': _emailcontroller.text.trim(),
          'phoneNumber': _phonecontroller.text.trim(),
        });

        // Navigate to EmptyState screen after successful registration
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const onboard()), // Home screen
        );
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
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            reverse: true,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: screenHeight * 1.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0x0092e1e2).withOpacity(1.0),
                            Color(0x000d4671).withOpacity(1.0),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 80),
                          Image.asset(
                            'assets/login/logo.png',
                            width: 70,
                            height: 60,
                          ),
                          const SizedBox(height: 20),
                          GradientText(
                            'SoftLocker',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                            colors: [
                              Color(0x002b2a7b).withOpacity(1.0),
                              Color(0x000071a5).withOpacity(1.0),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: 348,
                            decoration: BoxDecoration(
                              color: Color(0x00e7ebeb).withOpacity(1.0),
                              borderRadius: BorderRadius.circular(62),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Form(
                                key: _formkey,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                child: Column(
                                  children: [
                                    const Text(
                                      'Register',
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ..._buildInputFields(),
                                    const SizedBox(height: 20),
                                    _isLoading
                                        ? const CircularProgressIndicator()
                                        : ElevatedButton(
                                            onPressed: () {
                                              registerUser(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor: Color(0x000d4671)
                                                  .withOpacity(1.0),
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 50, vertical: 20),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(19),
                                              ),
                                            ),
                                            child: const Text('Create Account'),
                                          ),
                                    if (_errorMessage != null)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: Text(
                                          _errorMessage!,
                                          style: const TextStyle(
                                              color: Colors.red, fontSize: 14),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
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
                                'Or Register with',
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
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const loginscreen()),
                              );
                            },
                            child: RichText(
                              text: TextSpan(
                                text: "Already have an account? ",
                                style: const TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: 'Login Now',
                                    style: TextStyle(
                                      color: Color(0x0092e1e2).withOpacity(1.0),
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
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildInputFields() {
    return [
      _buildInputField(
        'Enter your Username',
        'assets/login/user.svg',
        TextInputType.emailAddress,
        controller: _usercontroller,
        validator: validateUsername,
      ),
      const SizedBox(height: 10),
      _buildInputField('Enter your Mobile Number', 'assets/login/mobile.svg',
          TextInputType.number,
          controller: _phonecontroller, validator: validatePhoneNumber),
      const SizedBox(height: 10),
      _buildInputField('Enter your E-mail', 'assets/login/email.svg',
          TextInputType.emailAddress,
          controller: _emailcontroller, validator: validateEmail),
      const SizedBox(height: 10),
      _buildInputField('Enter your Password', 'assets/login/eye.svg',
          TextInputType.visiblePassword,
          validator: validatePassword,
          controller: _passwordcontroller,
          obscureText: true),
      const SizedBox(height: 10),
      _buildInputField('Confirm your Password', 'assets/login/eye.svg',
          TextInputType.visiblePassword,
          validator: validateconfirmPassword,
          controller: _confirmpasswordcontroller,
          obscureText: true),
    ];
  }

  Widget _buildInputField(
    String hint,
    String assetPath,
    TextInputType inputType, {
    required TextEditingController controller,
    required String? Function(String?) validator,
    bool obscureText = false,
  }) {
    return Container(
      alignment: Alignment.center,
      width: 314,
      height: 56,
      decoration: BoxDecoration(
        color: Color(0x000d4671).withOpacity(1.0),
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
                color: Color(0x00fff5f5).withOpacity(1.0),
                borderRadius: BorderRadius.circular(19),
              ),
              child: TextFormField(
                obscureText: obscureText,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 129, 129, 129)),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                ),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
                keyboardType: inputType,
                controller: controller,
                validator: validator,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: SvgPicture.asset(assetPath, height: 24, width: 24),
            ),
          ),
        ],
      ),
    );
  }

  // Validation methods
  String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Username cannot be empty';
    }
    if (username.length < 3 || username.length > 20) {
      return 'Must be between 3 and 20 characters';
    }
    RegExp validUsernameRegex = RegExp(r'^[a-zA-Z0-9._]+$');
    if (!validUsernameRegex.hasMatch(username)) {
      return 'Username can only contain letters, numbers, underscores, and dots';
    }
    return null;
  }

  String? validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return 'Phone number cannot be empty';
    }
    RegExp phoneRegex = RegExp(r'^\d{10}$');
    if (!phoneRegex.hasMatch(phoneNumber)) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }

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
    RegExp uppercaseRegex = RegExp(r'[A-Z]');
    RegExp lowercaseRegex = RegExp(r'[a-z]');
    RegExp numberRegex = RegExp(r'\d');
    RegExp specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    if (!uppercaseRegex.hasMatch(password)) {
      return 'At least one uppercase letter';
    }
    if (!lowercaseRegex.hasMatch(password)) {
      return 'At least one lowercase letter';
    }
    if (!numberRegex.hasMatch(password)) {
      return 'At least one number';
    }
    if (!specialCharRegex.hasMatch(password)) {
      return 'At least one special character';
    }

    return null;
  }

  String? validateconfirmPassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password cannot be empty';
    }
    if (_confirmpasswordcontroller.text != _passwordcontroller.text) {
      return "Password is not the same";
    }
    return null;
  }
}
