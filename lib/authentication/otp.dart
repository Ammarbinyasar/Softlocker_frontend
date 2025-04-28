import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:vishayam/authentication/newpass.dart';
import 'package:pinput/pinput.dart';

final _formkey = GlobalKey<FormState>();

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final _otpcontroller = TextEditingController();

  movetonewpass(BuildContext context) {
    if (_formkey.currentState!.validate()) {
      setState(() {});
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CreateNewPassword(),
        ),
      );
    }
  }

  String? validateOTP(String? otp) {
    if (otp == null || otp.isEmpty) {
      return 'OTP cannot be empty';
    }

    // Check if OTP is numeric
    RegExp numericRegex = RegExp(r'^\d+$');
    if (!numericRegex.hasMatch(otp)) {
      return 'OTP must contain only numbers';
    }

    return null;
  }

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(0, 0, 0, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 255, 255, 255),
      border: Border.all(color: Color.fromRGBO(255, 255, 255, 1)),
      borderRadius: BorderRadius.circular(8),
    ),
  );

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
              height: 620,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0x0092e1e2).withOpacity(1.0),
                  Color(0x000d4671).withOpacity(1.0)
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(190),
                    topRight: Radius.circular(190)),
              ),
            ),
          ),
          SafeArea(
            child: Container(
              alignment: Alignment.center,
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
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    colors: [
                      Color(0x002b2a7b).withOpacity(1.0),
                      Color(0x000071a5).withOpacity(1.0),
                    ],
                  ),
                  const SizedBox(height: 100),
                  Text(
                    'Enter OTP',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(0, 255, 255, 255).withOpacity(1.0),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Enter the verification code we just sent on your\n email address.',
                    style: TextStyle(
                        color: Color.fromARGB(0, 48, 48, 48).withOpacity(1.0),
                        fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: _formkey,
                    //otppppppppppppppppppppppp
                    child: Pinput(
                      controller: _otpcontroller,
                      validator: validateOTP,
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      length: 4,
                      defaultPinTheme: defaultPinTheme,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => CreateNewPassword()),
                      // );
                      movetonewpass(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color(0x00ffffff).withOpacity(1.0),
                      backgroundColor: const Color(0x000d4671).withOpacity(1.0),
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(19),
                      ),
                    ),
                    child: Text('Verify OTP'),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {},
                    child: RichText(
                      text: TextSpan(
                        text: "Didn’t receive code?",
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: ' Resend',
                            style: TextStyle(
                                color: Color(0x000d4671).withOpacity(1.0),
                                fontWeight: FontWeight.bold),
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
