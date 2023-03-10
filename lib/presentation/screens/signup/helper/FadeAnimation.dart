import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:simple_animations/simple_animations.dart';

enum AniProps { opacity, translateY }
class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final TimelineTween<AniProps> tween = TimelineTween()
    ..addScene(begin: Duration(milliseconds: 0),end: const Duration(milliseconds: 500)).animate(AniProps.opacity, tween: Tween(begin: 0.0, end: 1.0))
    ..addScene(begin: Duration(milliseconds: 100),end: const Duration(milliseconds: 500)).animate(AniProps.translateY, tween: Tween(begin: -30.0, end: 0.0),curve:  Curves.easeOut
    );

    return PlayAnimation(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (BuildContext context, Widget? child, TimelineValue<dynamic> value) {
        return Opacity(
          opacity: value.get(AniProps.opacity),
          child: Transform.translate(
              offset: Offset(0, value.get(AniProps.translateY)),
              child: child
          ),
        );
    },
    );
  }
}
