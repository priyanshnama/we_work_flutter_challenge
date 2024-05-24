import 'package:we_work_flutter_challenge/data/user_address.dart';

abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashLoaded extends SplashState {
  final UserAddress userAddress;

  SplashLoaded(this.userAddress);
}

class SpalshError extends SplashState {
  final String message;
  SpalshError(this.message);
}