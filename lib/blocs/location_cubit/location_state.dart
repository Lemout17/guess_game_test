part of 'location_cubit.dart';

sealed class LocationState {
  final Location? location;

  const LocationState(this.location);

  bool get hasData => location != null;
}

final class LocationInitial extends LocationState {
  const LocationInitial() : super(null);
}

final class LocationLoaded extends LocationState {
  const LocationLoaded(super.location);
}

final class LocationError extends LocationState {
  final dynamic error;
  const LocationError(super.location, this.error);
}

final class LocationLoading extends LocationState {
  const LocationLoading(super.location);
}
