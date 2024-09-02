import 'package:energise_test_app/data/repositories/location_repository/i_location_repository.dart';
import 'package:energise_test_app/models/location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final ILocationRepository _locationRepository = GetIt.instance.get();
  LocationCubit() : super(const LocationInitial()) {
    getLocation();
  }

  Future<void> getLocation() async {
    try {
      emit(LocationLoading(state.location));

      final location = await _locationRepository.getLocation();

      if (location != null) {
        emit(LocationLoaded(location));
      } else {
        emit(LocationError(state.location, 'Location is null'));
      }
    } on Exception catch (e) {
      emit(LocationError(state.location, e));
    }
  }
}
