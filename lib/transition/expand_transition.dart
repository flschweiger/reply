import 'package:flutter/material.dart';
import 'package:reply/styling.dart';

class ExpandItemPageTransition extends StatelessWidget {
  const ExpandItemPageTransition({
    Key key,
    @required this.source,
    @required this.title,
    @required this.child,
  })  : assert(source != null),
        assert(title != null),
        assert(child != null),
        super(key: key);

  final Rect source;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = ModalRoute.of(context).animation;
    final double topDisplayPadding = MediaQuery.of(context).padding.top;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Animation<double> positionAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.fastOutSlowIn,
        );

        final Animation<RelativeRect> itemPosition = RelativeRectTween(
          begin: RelativeRect.fromLTRB(0, source.top, 0, constraints.biggest.height - source.bottom),
          end: RelativeRect.fill,
        ).animate(positionAnimation);

        final Animation<double> fadeMaterialBackground = CurvedAnimation(
          parent: animation,
          curve: const Interval(0.0, 0.2, curve: Curves.ease),
        );

        final double distanceToAvatar = topDisplayPadding + _calculateHeaderHeight(context, title) - 16;

        final Animation<Offset> contentOffset = Tween<Offset>(
          begin: Offset(0, -distanceToAvatar),
          end: Offset.zero,
        ).animate(positionAnimation);

        return Stack(
          children: <Widget>[
            PositionedTransition(
              rect: itemPosition,
              child: ClipRect(
                child: OverflowBox(
                  alignment: Alignment.topLeft,
                  minHeight: constraints.maxHeight,
                  maxHeight: constraints.maxHeight,
                  child: AnimatedBuilder(
                    animation: contentOffset,
                    child: FadeTransition(
                      opacity: fadeMaterialBackground,
                      child: Material(
                        color: AppTheme.nearlyWhite,
                        child: child,
                      ),
                    ),
                    builder: (BuildContext context, Widget child) {
                      return Transform.translate(
                        offset: contentOffset.value,
                        child: child,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  double _calculateHeaderHeight(BuildContext context, String msg) {
    final double maxWidth = MediaQuery.of(context).size.width - 80; // Padding on both sides and arrow button
    final TextSpan span = TextSpan(style: Theme.of(context).textTheme.display1, text: msg);
    final TextPainter painter = TextPainter(text: span, textDirection: TextDirection.ltr);
    painter.layout(minWidth: 0, maxWidth: maxWidth);
    return painter.height + 26;
  }
}
