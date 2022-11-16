import 'package:flutter/material.dart';

class RightToLeftAnim extends StatefulWidget {
  final Widget child;
  final int milliSecond;
  RightToLeftAnim({required this.child, required this.milliSecond});

  @override
  State<RightToLeftAnim> createState() => _RightToLeftAnimState();
}

class _RightToLeftAnimState extends State<RightToLeftAnim>
    with SingleTickerProviderStateMixin {
  late final AnimationController animCtrl;
  late final Animation<Offset> slideAnim;

  @override
  void initState() {
    super.initState();

    animCtrl = AnimationController(vsync: this, duration: Duration(seconds: 1));
    slideAnim = Tween(begin: Offset(1.2, 0.0), end: Offset.zero)
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
      child: widget.child,
    );
  }
}
