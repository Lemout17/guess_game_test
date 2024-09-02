import 'package:flutter/material.dart';

class PulseButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isRunning;

  const PulseButton(
      {super.key, required this.onPressed, required this.isRunning});

  @override
  State<PulseButton> createState() => _PulseButtonState();
}

class _PulseButtonState extends State<PulseButton>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  late final AnimationController _iconAnimationController;
  late final Animation<double> _iconAnimation;

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

    _iconAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _iconAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _iconAnimationController,
        curve: Curves.decelerate,
      ),
    );

    _animationController.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant PulseButton oldWidget) {
    if (widget.isRunning != oldWidget.isRunning) {
      if (widget.isRunning) {
        _animationController.animateTo(0.0);
        _iconAnimationController.forward();
      } else {
        _animationController.repeat(reverse: true);
        _iconAnimationController.reverse();
      }
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: widget.onPressed,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.primary.withOpacity(_animation.value),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary
                      .withOpacity(_animation.value * 0.5),
                  spreadRadius: (1 - _animation.value) * 40,
                  blurRadius: 5.0,
                )
              ],
            ),
            alignment: Alignment.center,
            child: AnimatedIcon(
              icon: AnimatedIcons.pause_play,
              progress: _iconAnimation,
              color: Colors.white,
              size: 32,
            ),
          );
        },
      ),
    );
  }
}
