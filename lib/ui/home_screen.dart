import 'package:flutter/material.dart';
import 'package:we_work_flutter_challenge/data/user_address.dart';
import 'package:we_work_flutter_challenge/ui/we_movies.dart';

class HomeScreen extends StatefulWidget {
  final UserAddress userAddress;

  const HomeScreen({super.key, required this.userAddress});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  AppBar customAppBar(TextTheme textTheme) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(Icons.location_on_outlined),
                    const SizedBox(width: 8),
                    Text(
                      widget.userAddress.mainAddress,
                      style: textTheme.bodyLarge
                          ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  widget.userAddress.secondaryAddress,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            ClipOval(
                child: Image.asset(
              'assets/icons/we_work_logo.png',
              height: 40,
              width: 40,
            ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: customAppBar(textTheme),
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.purple.shade100,
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: const WeMovies()),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'We Movies',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Upcoming',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
