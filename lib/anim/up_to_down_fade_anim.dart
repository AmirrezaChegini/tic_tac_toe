import 'package:flutter/material.dart';

class UpToDownFadeAnim extends StatefulWidget {
  final Widget child;
  final int milliSecond;
  UpToDownFadeAnim({required this.child, required this.milliSecond});

  @override
  State<UpToDownFadeAnim> createState() => _UpToDownFadeAnimState();
}

class _UpToDownFadeAnimState extends State<UpToDownFadeAnim>
    with SingleTickerProviderStateMixin {
  late final AnimationController animCtrl;
  late final Animation<double> fadeAnim;
  late final Animation<Offset> slideAnim;

  @override
  void initState() {
    super.initState();

    animCtrl = AnimationController(vsync: this, duration: Duration(seconds: 1));
    fadeAnim = CurvedAnimation(parent: animCtrl, curve: Curves.easeInOut);
    slideAnim = Tween(begin: Offset(0.0, -0.5), end: Offset.zero)
        .animate(CurvedAnimation(parent: animCtrl, curve: Curves.easeInOut));
    showAnim(widget.milliSecond);
  }

  Future<void> showAnim(int milliSecond) async {
    Future.delayed(
      Duration(milliseconds: milliSecond),
      () async {
        await animCtrl.forward();
      },
    );
  }

  @override
  void dispose() {
    animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slideAnim,
      child: FadeTransition(
        opacity: fadeAnim,
        child: widget.child,
      ),
    );
  }
}
