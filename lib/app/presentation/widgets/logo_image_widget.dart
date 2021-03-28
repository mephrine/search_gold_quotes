import 'package:flutter/material.dart';

class LogoImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'images/logo.png',
      width: 50,
      height: 25,
    );
  }
}
