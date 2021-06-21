import 'dart:ui';

import 'package:flutter/material.dart';

class ShadowImage extends StatelessWidget {
  final String imagePath;
  final BoxFit? boxFit;

  const ShadowImage(this.imagePath, {Key? key, this.boxFit = BoxFit.contain}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
          top: -10,
          right: -20,
          left: 30,
          bottom: 10,
          child: Opacity(child: Image.asset(imagePath, color: Colors.black, fit: boxFit), opacity: 0.35)),
      Positioned(
        top: 0,
        right: 0,
        left: 0,
        bottom: 0,
        child: ClipRect(
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 14.0, sigmaY: 8.0),
                child: Image.asset(imagePath, fit: boxFit))),
      )
    ]);
  }
}
