import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:vishayam/onboarding/onboarding.dart';

final _Formkey = GlobalKey<FormState>();

class Verifyacc extends StatefulWidget {
  const Verifyacc({super.key});

  @override
  State<Verifyacc> createState() => _VerifyaccState();
}

class _VerifyaccState extends State<Verifyacc> {
  final _verifycontroller = TextEditingController();

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
            color: const Color(0x00ffffff).withOpacity(1.0),
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
          SafeArea(
            child: Align(
              alignment: Alignment.center,
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
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.w600),
                      colors: [
                        const Color(0x002b2a7b).withOpacity(1.0),
                        const Color(0x000071a5).withOpacity(1.0),
                      ]),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Verify Your Identity',
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                        color:
                            const Color.fromARGB(0, 0, 0, 0).withOpacity(1.0)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'We’ve sent a verification code by SMS to\n+91 xxxxx xxx65',
                    style: TextStyle(
                        color: const Color.fromARGB(0, 77, 77, 77)
                            .withOpacity(1.0),
                        fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 314,
                    height: 56,
                    decoration: BoxDecoration(
                      color: const Color(0x000d4671).withOpacity(1.0),
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
                              color: const Color(0x00fff5f5).withOpacity(1.0),
                              borderRadius: BorderRadius.circular(19),
                            ),
                            child: Form(
                              key: _Formkey,
                              child: TextFormField(
                                controller: _verifycontroller,
                                decoration: const InputDecoration(
                                  hintText: 'Enter Your Verification Code',
                                  hintStyle: TextStyle(
                                      color:
                                          Color.fromARGB(255, 129, 129, 129)),
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                ),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: SvgPicture.asset(
                              'assets/login/eye.svg',
                              height: 24,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => onboard()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor:
                          const Color.fromARGB(0, 0, 0, 0).withOpacity(1.0),
                      backgroundColor: const Color(0x0092e1e2).withOpacity(1.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19)),
                    ),
                    child: const Text('Continue'),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: GestureDetector(
                      onTap: () {},
                      child: RichText(
                        text: TextSpan(
                          text: "Didn’t receive a code?  ",
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'Resend SMS',
                              style: TextStyle(
                                  color: Color(0x000071a5).withOpacity(1.0),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
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
