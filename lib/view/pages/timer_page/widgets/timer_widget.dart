import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget(
      {super.key, required this.stopwatch, required this.isRunning});

  final Stopwatch stopwatch;
  final bool isRunning;

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1, end: 0.6).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TimerWidget oldWidget) {
    if (widget.isRunning != oldWidget.isRunning) {
      if (widget.isRunning) {
        _animationController.repeat(reverse: true);
      } else {
        _animationController.animateTo(0.0);
      }
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        Duration duration = widget.stopwatch.elapsed;

        return Text(
          '${_twoDigit(duration.inHours)}:'
          '${_twoDigit(duration.inMinutes.remainder(60))}:'
          '${_twoDigit(duration.inSeconds.remainder(60))}',
          style: TextStyle.lerp(
            const TextStyle(
              fontSize: 44,
              color: Colors.black,
              shadows: [
                Shadow(
                  blurRadius: 0,
                  color: Colors.grey,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            const TextStyle(
              fontSize: 44,
              color: Colors.black54,
              shadows: [
                Shadow(
                  blurRadius: 10,
                  color: Colors.black54,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            _animation.value,
          ),
        );
      },
    );
  }

  String _twoDigit(int n) => n.toString().padLeft(2, '0');
}
