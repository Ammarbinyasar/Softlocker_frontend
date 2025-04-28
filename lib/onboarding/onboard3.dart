import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Onboard3 extends StatelessWidget {
  const Onboard3({super.key});

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
                  SafeArea(child: SvgPicture.asset('assets/onboard/onb3.svg'))),
          Text(
            'Your Files, Your Rules:\n Customize or Let Us Handle It',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Organize Your Files Your Way or Let Us Do It for You',
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
