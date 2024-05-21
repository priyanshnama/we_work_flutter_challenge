import 'package:flutter/material.dart';
import 'package:we_work_flutter_challenge/ui/util/gradient_line.dart';

class WeMovies extends StatefulWidget {
  const WeMovies({super.key});

  @override
  State<WeMovies> createState() => _WeMoviesState();
}

class _WeMoviesState extends State<WeMovies> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // search bar
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search Movies by name ...',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            // now playing
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [const Text("NOW PLAYING"), GradientLine(Colors.black)],
            ),

            const SizedBox(
              height: 20,
            ),

            //top rated
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [const Text("TOP RATED"), GradientLine(Colors.black)],
            )
          ],
        ),
      ),
    );
  }
}
