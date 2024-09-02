import 'package:energise_test_app/view/pages/timer_page/widgets/pulse_button.dart';
import 'package:energise_test_app/view/pages/timer_page/widgets/timer_widget.dart';
import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage>
    with AutomaticKeepAliveClientMixin {
  final Stopwatch _stopwatch = Stopwatch();
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TimerWidget(
          stopwatch: _stopwatch,
          isRunning: _stopwatch.isRunning,
        ),
        const SizedBox(height: 10.0),
        PulseButton(
          onPressed: () => _onPressed(context),
          isRunning: _stopwatch.isRunning,
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _onPressed(BuildContext context) {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
    } else {
      _stopwatch.start();
    }

    setState(() {});
  }
}
