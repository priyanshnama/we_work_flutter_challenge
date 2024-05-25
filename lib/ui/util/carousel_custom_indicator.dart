import 'package:flutter/material.dart';

class CarouselCustomIndicator extends StatelessWidget {
  final int current;
  final int totalSize;

  const CarouselCustomIndicator(
      {super.key, required this.current, required this.totalSize});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (current > 0)
          Container(
            width: 8.0,
            height: 8.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black
                  .withOpacity(0.4),
            ),
          ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '${current + 1}/$totalSize',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        if (current < totalSize - 1)
          Row(
            children: [
              Container(
                width: 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black
                      .withOpacity(0.4),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
