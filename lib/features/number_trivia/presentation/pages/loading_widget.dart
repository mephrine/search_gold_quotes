import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 3,
      child: Center(
        child: SingleChildScrollView(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}