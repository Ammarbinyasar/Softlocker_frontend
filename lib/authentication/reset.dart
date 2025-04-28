import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:vishayam/authentication/login1.dart';

class changed extends StatelessWidget {
  const changed({super.key});

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
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 357,
                      height: 455,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0x0092e1e2).withOpacity(1.0),
                          borderRadius: BorderRadius.circular(90)),
                      child: Column(
                        children: [
                          Image.asset('assets/login/tick.png'),
                          Text(
                            'Password Changed Sucessfully!',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => loginscreen()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor:
                                  const Color(0x00ffffff).withOpacity(1.0),
                              backgroundColor:
                                  const Color(0x000d4671).withOpacity(1.0),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(19),
                              ),
                            ),
                            child: Text('Back to Login'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
