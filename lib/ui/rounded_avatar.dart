import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RoundedAvatar extends StatefulWidget {
  const RoundedAvatar({Key key, @required this.image})
      : assert(image != null),
        super(key: key);

  final String image;

  @override
  _RoundedAvatarState createState() => _RoundedAvatarState();
}

class _RoundedAvatarState extends State<RoundedAvatar> {
  @override
  Widget build(BuildContext context) {
    return Material(
      shape: CircleBorder(
        side: BorderSide(color: const Color(0xFFEEF1F3), width: 1),
      ),
      clipBehavior: Clip.hardEdge,
      child: Image.asset(
        widget.image,
        width: 36,
        height: 36,
      ),
    );
  }
}
