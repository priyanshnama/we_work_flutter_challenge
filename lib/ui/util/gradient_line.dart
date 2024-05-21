import 'package:flutter/material.dart';

class GradientLine extends StatelessWidget {

  final Color color;

  GradientLine(this.color);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // Adjust the width as needed
      height: 1,  // This defines the thickness of the line
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, Colors.transparent],
        ),
      ),
    );
  }
}