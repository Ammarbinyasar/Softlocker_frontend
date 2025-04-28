import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vishayam/onboarding/onboard1.dart';
import 'package:vishayam/onboarding/onboard2.dart';
import 'package:vishayam/onboarding/onboard3.dart';
import 'package:vishayam/home/empty_state.dart';

class onboard extends StatefulWidget {
  const onboard({super.key});

  @override
  State<onboard> createState() => _onboardState();
}

class _onboardState extends State<onboard> {
  final PageController _controller = PageController();
  bool onlast = false;
  bool onfirst = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color.fromARGB(0, 255, 255, 255).withOpacity(1.0),
            child: Stack(
              children: [
                PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      onlast = (index == 2);
                      onfirst = (index == 0);
                    });
                  },
                  children: [
                    Onboard1(),
                    Onboard2(),
                    Onboard3(),
                  ],
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'WELCOME',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SmoothPageIndicator(
                      controller: _controller,
                      count: 3,
                      effect: ExpandingDotsEffect(
                        spacing: 11.0,
                        radius: 20.0,
                        dotHeight: 12,
                        dotColor: Color(0x0067a869).withOpacity(1.0),
                        activeDotColor: Color(0x0082d5db).withOpacity(1.0),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Ensures the buttons are at the left and right
                        children: [
                          // Previous button always on the left
                          onfirst
                              ? SizedBox(
                                  width:
                                      48) // Same width as IconButton to maintain alignment
                              : IconButton(
                                  onPressed: () {
                                    _controller.previousPage(
                                      duration: Duration(seconds: 1),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  icon: SvgPicture.asset(
                                      'assets/onboard/prev.svg'),
                                ),

                          // Spacer to push buttons apart or ensure proper alignment
                          onlast
                              ? IconButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EmptyState(),
                                      ),
                                    );
                                  },
                                  icon: SvgPicture.asset(
                                      'assets/onboard/nex.svg'),
                                )
                              : IconButton(
                                  onPressed: () {
                                    _controller.nextPage(
                                      duration: Duration(seconds: 1),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  icon: SvgPicture.asset(
                                      'assets/onboard/nex.svg'),
                                ), // Next button always on the right
                        ],
                      ),
                    ),
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
