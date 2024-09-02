import 'package:easy_localization/easy_localization.dart';
import 'package:energise_test_app/core/constants.dart';
import 'package:energise_test_app/localization/generated/codegen_loader.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RateAppDialog {
  static Future<void> promptAppRating(BuildContext context) {
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(LocaleKeys.rateAppDialogTitle.tr()),
          content: Column(
            children: [
              Text(LocaleKeys.rateAppDialogDescription.tr()),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Expanded(
                    child: IconButton(
                      icon: const Icon(
                        Icons.star_border,
                        color: Colors.orange,
                        size: 30,
                      ),
                      onPressed: () => _openRateDialog(context, index + 1),
                    ),
                  );
                }),
              ),
            ],
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(LocaleKeys.notNowBtn.tr()),
            ),
          ],
        );
      },
    );
  }

  static Future<void> _promptRatingSubmitted(BuildContext context, int rating) {
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(LocaleKeys.thankYouBtn.tr()),
          content: Text(
            LocaleKeys.rateAppDialogText.tr(
              args: [LocaleKeys.stars.plural(rating)],
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(LocaleKeys.okText.tr()),
            ),
            CupertinoDialogAction(
              onPressed: () => _openAppStore(context),
              child: Text(LocaleKeys.rateNowBtn.tr()),
            ),
          ],
        );
      },
    );
  }

  RateAppDialog._();

  static Future<void> _openAppStore(BuildContext context) async {
    final url = Uri.parse(Constants.appleStore);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
    if (!context.mounted) return;

    Navigator.of(context).pop();
  }

  static _openRateDialog(BuildContext context, int rating) {
    Navigator.of(context).pop();
    _promptRatingSubmitted(context, rating);
  }
}
