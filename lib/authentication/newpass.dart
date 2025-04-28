import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vishayam/authentication/reset.dart';

final _formkey = GlobalKey<FormState>();

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  final _passwordcontroller = TextEditingController();
  final _confirmpasswordcontroller = TextEditingController();
  movetoreset(BuildContext context) {
    if (_formkey.currentState!.validate()) {
      setState(() {});
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const changed(),
        ),
      );
    }
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password cannot be empty';
    }

    // Check minimum length
    if (password.length < 8) {
      return 'Password must be at least 8 characters';
    }

    // Check for uppercase, lowercase, number, and special character
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

    // Check minimum length
    else if (_confirmpasswordcontroller.text != _passwordcontroller.text) {
      return "Password is not same";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 30),
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(color: Color(0x000fffff)),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 600,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0x0092e1e2).withOpacity(1.0),
                  Color(0x000d4671).withOpacity(1.0)
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(90),
                    topRight: Radius.circular(90)),
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.center,
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/login/logo.png',
                      width: 70,
                      height: 60,
                    ),
                    const SizedBox(height: 20),
                    GradientText(
                      'SoftLocker',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                      colors: [
                        Color(0x002b2a7b).withOpacity(1.0),
                        Color(0x000071a5).withOpacity(1.0),
                      ],
                    ),
                    const SizedBox(height: 100),
                    Text(
                      'Create New Password',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color:
                            Color.fromARGB(0, 255, 255, 255).withOpacity(1.0),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    //password
                    Container(
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
                                controller: _passwordcontroller,
                                validator: validatePassword,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText:
                                      'Enter your Password', // Placeholder text
                                  hintStyle: TextStyle(
                                      color: const Color.fromARGB(255, 129, 129,
                                          129)), // Style of the hint text
                                  border: InputBorder
                                      .none, // Remove the default underline border
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.0), // Add padding
                                ),
                                style: TextStyle(
                                  color:
                                      Colors.black, // Style for the input text
                                  fontSize: 16.0,
                                ),
                                keyboardType: TextInputType
                                    .visiblePassword, // Keyboard optimized for password input
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment
                                .centerRight, // Aligns the SVG to the rightmost
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: 10.0), // Add padding to the right
                              child: SvgPicture.asset(
                                'assets/login/eye.svg',
                                height: 24, // Adjust SVG size as needed
                                width: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    //password
                    Container(
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
                                validator: validateconfirmPassword,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _confirmpasswordcontroller,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText:
                                      'Re-Enter your Password', // Placeholder text
                                  hintStyle: TextStyle(
                                      color: const Color.fromARGB(255, 129, 129,
                                          129)), // Style of the hint text
                                  border: InputBorder
                                      .none, // Remove the default underline border
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.0), // Add padding
                                ),
                                style: TextStyle(
                                  color:
                                      Colors.black, // Style for the input text
                                  fontSize: 16.0,
                                ),
                                keyboardType: TextInputType
                                    .visiblePassword, // Keyboard optimized for password input
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment
                                .centerRight, // Aligns the SVG to the rightmost
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: 10.0), // Add padding to the right
                              child: SvgPicture.asset(
                                'assets/login/eye.svg',
                                height: 24, // Adjust SVG size as needed
                                width: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => changed(),
                        //   ),
                        // );
                        movetoreset(context);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor:
                            const Color(0x00ffffff).withOpacity(1.0),
                        backgroundColor:
                            const Color(0x000d4671).withOpacity(1.0),
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19),
                        ),
                      ),
                      child: Text('Reset Your Password'),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
