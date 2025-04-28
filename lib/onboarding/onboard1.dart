import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Onboard1 extends StatelessWidget {
  const Onboard1({super.key});

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
                  SafeArea(child: SvgPicture.asset('assets/onboard/onb1.svg'))),
          Text(
            'Effortless and Secure File\n Uploads at Your Fingertips',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Upload with Ease, Secure with Confidence',
            style: TextStyle(
              fontSize: 10,
            ),
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }
}
