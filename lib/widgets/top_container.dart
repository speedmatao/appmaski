import 'package:flutter/material.dart';

import '../theme/light_colors.dart';

class TopContainer extends StatelessWidget {
  const TopContainer(
      {Key? key,
      this.height,
      required this.width,
      required this.child,
      this.padding,
      this.redondo})
      : super(key: key);

  final Widget child;
  final double? height;
  final EdgeInsets? padding;
  final double width;
  final bool? redondo;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(0, 2), // changes position of shadow
              spreadRadius: 5,
            )
          ],
          color: LightColors().klilinfuerte2,
          borderRadius: BorderRadius.only(
            topLeft: redondo ?? false
                ? const Radius.circular(20.0)
                : const Radius.circular(0.0),
            topRight: redondo ?? false
                ? const Radius.circular(20.0)
                : const Radius.circular(0.0),
            bottomRight: redondo ?? false
                ? const Radius.circular(30.0)
                : const Radius.circular(0.0),
            bottomLeft: redondo ?? false
                ? const Radius.circular(30.0)
                : const Radius.circular(0.0),
          )),
      height: height,
      width: width,
      child: child,
    );
  }
}
