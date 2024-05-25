import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work_flutter_challenge/bloc/splash/splash_events.dart';
import 'package:we_work_flutter_challenge/bloc/splash/splash_states.dart';
import 'package:we_work_flutter_challenge/service/location_service.dart';
import 'package:we_work_flutter_challenge/ui/home_screen.dart';
import 'package:we_work_flutter_challenge/bloc/splash/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocProvider(
      create: (context) {
        final splashBloc = SplashBloc(LocationService());
        splashBloc.add(FetchLocationEvent());
        return splashBloc;
      },
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashLoaded) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        userAddress: state.userAddress,
                      )),
            );
          } else if (state is SpalshError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Stack(
            children: [
              Center(
                child: Image.asset(
                  'assets/icons/we_work_logo_large.png',
                  height: 200,
                  width: 200,
                ),
              ),
              const Center(
                child: SizedBox(
                  width: 190,
                  height: 190,
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
