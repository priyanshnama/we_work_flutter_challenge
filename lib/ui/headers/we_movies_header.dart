import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:we_work_flutter_challenge/ui/util/custom_shape_clipper.dart';

class WeMoviesHeader extends StatelessWidget {
  final int numberOfMovies;
  const WeMoviesHeader({super.key, required this.numberOfMovies});

  String getTodaysDate() {
    final date = DateTime.now();
    String getDaySuffix(int day) {
      if (day >= 11 && day <= 13) return 'th';
      switch (day % 10) {
        case 1:
          return 'st';
        case 2:
          return 'nd';
        case 3:
          return 'rd';
        default:
          return 'th';
      }
    }

    String day = '${date.day}${getDaySuffix(date.day)}';
    String month = DateFormat('MMM').format(date).toUpperCase();
    String year = DateFormat('yyyy').format(date);

    return '$day $month $year';
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Stack(
      children: [
        ClipPath(
          clipper: CustomShapeClipper(topHeight: 40, bottomHeight: 60),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.3)
                ])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text('We Movies',
                    style: textTheme.headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text('$numberOfMovies Movies are loaded in now playing',
                    style: textTheme.bodySmall),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: Text(getTodaysDate(), style: textTheme.bodyMedium),
        ),
      ],
    );
  }
}
