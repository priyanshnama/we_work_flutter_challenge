import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work_flutter_challenge/bloc/splash/splash_events.dart';
import 'package:we_work_flutter_challenge/bloc/splash/splash_states.dart';
import 'package:we_work_flutter_challenge/service/location_service.dart';

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
