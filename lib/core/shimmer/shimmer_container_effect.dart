import 'package:flutter/material.dart';

class CustomFadingAnimation extends StatefulWidget {
  const CustomFadingAnimation({super.key, required this.child});
  final Widget child;

  @override
  State<CustomFadingAnimation> createState() => _CustomFadingAnimationState();
}

class _CustomFadingAnimationState extends State<CustomFadingAnimation>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    animation = Tween<double>(begin: .2, end: .8).animate(animationController);
    animationController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: animation.value,
      child: widget.child,
    );
  }
}
