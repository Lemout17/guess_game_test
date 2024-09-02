import 'package:easy_localization/easy_localization.dart';
import 'package:energise_test_app/data/api/api.dart';
import 'package:energise_test_app/data/api/i_api.dart';
import 'package:energise_test_app/data/repositories/location_repository/i_location_repository.dart';
import 'package:energise_test_app/data/repositories/location_repository/location_repository.dart';
import 'package:energise_test_app/view/app.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  GetIt.instance.registerSingleton<IApi>(Api());
  GetIt.instance.registerSingleton<ILocationRepository>(LocationRepository());

  runApp(const App());
}
