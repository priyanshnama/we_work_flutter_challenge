import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work_flutter_challenge/data/user_address.dart';
import 'package:we_work_flutter_challenge/service/location_service.dart';

// Define the events
abstract class SplashEvent {}

class FetchLocationEvent extends SplashEvent {}

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

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final LocationService locationService;

  SplashBloc(this.locationService) : super(SplashInitial()) {
    on<FetchLocationEvent>((event, emit) async {
      emit(SplashLoading());
      try {
        final userAddress = await locationService.getAddressFromLatLng();
        emit(SplashLoaded(userAddress));
      } catch (e) {
        emit(SpalshError("Failed to fetch Location"));
      }
    });
  }
}
