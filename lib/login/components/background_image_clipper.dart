import 'package:flutter/material.dart';

import 'curve_clipper.dart';

class BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ClipPath(
      clipper: CurveClipper(),
      child: Container(
        height: size.height * 0.4,
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20.0 / 2, vertical: 20.0 * 3),
          child: Center(
            child: Image(
              width: 150,
              height: 150,
              image: AssetImage('assets/image/network.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
