import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/controller/game_controller.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({super.key, required this.gameController});

  final GameController gameController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DelayedWidget(
            animation: DelayedAnimations.SLIDE_FROM_LEFT,
            delayDuration: const Duration(milliseconds: 200),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white),
              ),
              child: Obx(
                () => Text(
                  '${gameController.playerName1} : ${gameController.player1Score.value}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: DelayedWidget(
            animation: DelayedAnimations.SLIDE_FROM_TOP,
            delayDuration: const Duration(milliseconds: 200),
            child: const Text(
              'VS',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          child: DelayedWidget(
            animation: DelayedAnimations.SLIDE_FROM_RIGHT,
            delayDuration: const Duration(milliseconds: 200),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white),
              ),
              child: Obx(
                () => Text(
                  '${gameController.playerName2} : ${gameController.player2Score.value}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
