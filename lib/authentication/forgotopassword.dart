import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:vishayam/authentication/otp.dart';

final _formkey = GlobalKey<FormState>();

class forgott extends StatefulWidget {
  const forgott({super.key});

  @override
  State<forgott> createState() => _forgottState();
}

class _forgottState extends State<forgott> {
  final _emailcontroller = TextEditingController();

  movetotp(BuildContext context) {
    if (_formkey.currentState!.validate()) {
      setState(() {});
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OtpVerification(),
        ),
      );
    }
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email cannot be empty';
    }

    // Check if the email contains an "@" symbol
    if (!email.contains('@')) {
      return 'Email must contain "@" symbol';
    }

    // Check for valid email structure using a regular expression
    RegExp emailRegex = RegExp(r'^[\w.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
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
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0x0092e1e2).withOpacity(1.0),
                Color(0x000d4671).withOpacity(1.0),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: SafeArea(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/login/logo.png',
                      width: 70,
                      height: 60,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GradientText('SoftLocker',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                        colors: [
                          Color(0x002b2a7b).withOpacity(1.0),
                          Color(0x000071a5).withOpacity(1.0),
                        ]),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Forgot Password?',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0x00273b4a).withOpacity(1.0)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Enter your email to receive an email to reset\n your password',
                      style:
                          TextStyle(color: Color(0x00606165).withOpacity(1.0)),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
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
                          //whitebox
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Form(
                              key: _formkey,
                              child: Container(
                                width: 275,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: Color(0x00fff5f5).withOpacity(1.0),
                                  borderRadius: BorderRadius.circular(19),
                                ),
                                child: TextFormField(
                                  validator: validateEmail,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: _emailcontroller,
                                  decoration: InputDecoration(
                                    hintText: 'E-mail', // Placeholder text
                                    hintStyle: TextStyle(
                                        color: const Color.fromARGB(
                                            255,
                                            129,
                                            129,
                                            129)), // Style of the hint text
                                    border: InputBorder
                                        .none, // Remove the default underline border
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16.0), // Add padding
                                  ),
                                  style: TextStyle(
                                    color: Colors
                                        .black, // Style for the input text
                                    fontSize: 16.0,
                                  ),
                                  keyboardType: TextInputType
                                      .emailAddress, // Keyboard optimized for email input
                                ),
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
                                'assets/login/email.svg',
                                height: 24, // Adjust SVG size as needed
                                width: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => OtpVerification()),
                        // );
                        movetotp(context);
                      },
                      style: ElevatedButton.styleFrom(
                          foregroundColor:
                              const Color(0x00ffffff).withOpacity(1.0),
                          backgroundColor: const Color(0x000d4671)
                              .withOpacity(1.0), // Text color
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(19))
                          // Shadow effect
                          ),
                      child: Text('Continue'),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
