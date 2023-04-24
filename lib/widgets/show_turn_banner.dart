import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/controller/game_controller.dart';

class ShowTurnBanner extends StatelessWidget {
  const ShowTurnBanner({super.key, required this.gameController});

  final GameController gameController;

  @override
  Widget build(BuildContext context) {
    return DelayedWidget(
      animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
      delayDuration: const Duration(milliseconds: 400),
      child: Container(
        width: 200,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white),
        ),
        child: Obx(
          () => Text(
            gameController.playerTurn.value == 1
                ? '${gameController.playerName1} \'s TURN'
                : '${gameController.playerName2} \'s TURN',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
