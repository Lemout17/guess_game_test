import 'package:energise_test_app/models/location.dart';

abstract class ILocationRepository {
  Future<Location?> getLocation();
}
