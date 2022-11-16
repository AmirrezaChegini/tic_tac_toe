import 'package:flutter/material.dart';

class ScaleAnim extends StatefulWidget {
  final Widget child;
  final bool isWin;
  ScaleAnim({required this.child, required this.isWin});

  @override
  State<ScaleAnim> createState() => _ScaleAnimState();
}

class _ScaleAnimState extends State<ScaleAnim>
    with SingleTickerProviderStateMixin {
  late final AnimationController animCtrl;
  late final Animation<double> scaleAnim;

  @override
  void initState() {
    super.initState();

    animCtrl =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    scaleAnim = CurvedAnimation(parent: animCtrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.isWin ? animCtrl.forward() : animCtrl.reverse();
    return ScaleTransition(
      scale: scaleAnim,
      child: widget.child,
    );
  }
}
