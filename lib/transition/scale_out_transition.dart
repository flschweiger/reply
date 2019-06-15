import 'package:flutter/material.dart';

class ScaleOutTransition extends StatelessWidget {
  const ScaleOutTransition({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Animation<double> primary = ModalRoute.of(context).animation;
    final Animation<double> secondary = ModalRoute.of(context).secondaryAnimation;

    final Animation<double> scaleIn = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: primary,
        curve: const Interval(0, 1, curve: Curves.fastOutSlowIn),
      ),
    );

    final Animation<double> scaleOut = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(
        parent: secondary,
        curve: const Interval(0.1, 0.8, curve: Curves.fastOutSlowIn),
      ),
    );

    final Animation<double> opacityOut = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(secondary);

    return Container(
      color: Theme.of(context).canvasColor,
      child: ScaleTransition(
        scale: scaleIn,
        child: ScaleTransition(
          scale: scaleOut,
          child: FadeTransition(
            opacity: primary,
            child: FadeTransition(
              opacity: opacityOut,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
