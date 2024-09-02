import 'package:easy_localization/easy_localization.dart';
import 'package:energise_test_app/blocs/location_cubit/location_cubit.dart';
import 'package:energise_test_app/localization/localization_preferences.dart';
import 'package:energise_test_app/view/pages/main_page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return  EasyLocalization(
      supportedLocales: LocalizationPreferences.supportedLocales,
      path: LocalizationPreferences.path,
      fallbackLocale: LocalizationPreferences.fallbackLocale,
      child: Builder(
        builder: (context) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            home: BlocProvider(
              create: (_) => LocationCubit(),
              child: const MainPage(),
            ),
          );
        }
      ),
    );
  }
}
