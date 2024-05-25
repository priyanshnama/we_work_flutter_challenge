import 'package:flutter/material.dart';

class CustomShapeClipper extends CustomClipper<Path> {
  final double topHeight;
  final double topBarOffset;
  final double bottomHeight;

  CustomShapeClipper({required this.topHeight, required this.bottomHeight, this.topBarOffset = 0});

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, topHeight * 3/2);

    path.quadraticBezierTo(0, topHeight, topHeight/2, topHeight);
    path.lineTo((size.width - topHeight)/2 + topBarOffset, topHeight);

    path.quadraticBezierTo(size.width / 2 + topBarOffset, topHeight, size.width / 2 + topBarOffset, topHeight/2);
    path.quadraticBezierTo(size.width / 2 + topBarOffset, 0, (size.width + topHeight)/2 + topBarOffset, 0);

    path.lineTo(size.width - topHeight/2, 0);
    path.quadraticBezierTo(size.width, 0, size.width, bottomHeight/2);
    path.lineTo(size.width, size.height - bottomHeight*3/2);

    path.quadraticBezierTo(size.width, size.height - bottomHeight,
        size.width - bottomHeight/2, size.height - bottomHeight);
    path.quadraticBezierTo(size.width - bottomHeight, size.height - bottomHeight,
        size.width - bottomHeight, size.height - bottomHeight/2);
    path.quadraticBezierTo(size.width - bottomHeight, size.height,
        size.width - (bottomHeight * 3/2), size.height);

    path.lineTo(topHeight/2, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - topHeight/2);
    path.lineTo(0, topHeight*3/2);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
