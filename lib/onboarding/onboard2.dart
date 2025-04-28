import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Onboard2 extends StatelessWidget {
  const Onboard2({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 50),
              child:
                  SafeArea(child: SvgPicture.asset('assets/onboard/onb2.svg'))),
          Text(
            'Your Files, Your Way: \nAnytime, Anywhere Access',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Access Your Files Anytime, Anywhere with Ease and\n Security',
            style: TextStyle(
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
