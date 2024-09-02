import 'package:easy_localization/easy_localization.dart';
import 'package:energise_test_app/localization/generated/codegen_loader.g.dart';
import 'package:energise_test_app/localization/localization_preferences.dart';
import 'package:energise_test_app/view/pages/info_page/info_page.dart';
import 'package:energise_test_app/view/pages/map_page/map_page.dart';
import 'package:energise_test_app/view/pages/timer_page/timer_page.dart';
import 'package:flutter/material.dart';

enum MainPageTab { timer, map, info }

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: MainPageTab.values.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.appBarMain.tr()),
          centerTitle: true,
          actions: [
            DropdownButton<Locale>(
              padding: const EdgeInsets.only(right: 20.0),
              value: context.locale,
              items: LocalizationPreferences.supportedLocales
                  .map(
                    (l) => DropdownMenuItem<Locale>(
                      value: l,
                      child: Text(l.languageCode.toUpperCase()),
                    ),
                  )
                  .toList(),
              onChanged: (value) => _onChanged(context, value),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: LocaleKeys.tabTimer.tr()),
              Tab(text: LocaleKeys.tabMap.tr()),
              Tab(text: LocaleKeys.tabInfo.tr()),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TimerPage(),
            MapPage(),
            InfoPage(),
          ],
        ),
      ),
    );
  }

  Future<void> _onChanged(BuildContext context, Locale? value) async {
    if (value != null) {
      await context.setLocale(value);

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            LocaleKeys.languageSnackBar
                .tr(args: [value.languageCode.toUpperCase()]),
          ),
        ),
      );
    }
  }
}
