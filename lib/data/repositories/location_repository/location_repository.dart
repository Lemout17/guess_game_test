import 'dart:math';

import 'package:energise_test_app/data/api/i_api.dart';
import 'package:energise_test_app/data/repositories/location_repository/i_location_repository.dart';
import 'package:energise_test_app/models/location.dart';
import 'package:get_it/get_it.dart';

class LocationRepository implements ILocationRepository {
  final IApi _api = GetIt.instance.get();
  @override
  Future<Location?> getLocation() async {
    try {
      String ip = _generateRandomIp();
      final response = await _api.getLocation(ip);
      if (response.data['status'] == 'success') {
        Location location = Location.fromJson(response.data);
        return location;
      }
      return null;
    } on Exception {
      rethrow;
    }
  }

  String _generateRandomIp() {
    final rand = Random();

    return '${rand.nextInt(256)}.${rand.nextInt(256)}.${rand.nextInt(256)}.${rand.nextInt(256)}';
  }
}
