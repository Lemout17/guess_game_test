import 'package:easy_localization/easy_localization.dart';
import 'package:energise_test_app/core/constants.dart';
import 'package:energise_test_app/localization/generated/codegen_loader.g.dart';
import 'package:energise_test_app/view/pages/info_page/widgets/rate_app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => RateAppDialog.promptAppRating(context),
            child: Text(LocaleKeys.rateAppBtn.tr()),
          ),
          const SizedBox(width: 10.0),
          ElevatedButton(
            onPressed: _shareApp,
            child: Text(LocaleKeys.shareAppBtn.tr()),
          ),
          const SizedBox(width: 10.0),
          ElevatedButton(
            onPressed: _contactUs,
            child: Text(LocaleKeys.contactUsBtn.tr()),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Future<ShareResult> _shareApp() {
    return Share.share(
      LocaleKeys.shareDescription.tr(args: [Constants.googlePlay]),
    );
  }

  Future<void> _contactUs() async {
    final url = Uri.parse(Constants.contactUs);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
    if (!context.mounted) return;
  }
}
