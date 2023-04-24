import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/controller/game_controller.dart';

class ShowWinnerBanner extends StatelessWidget {
  const ShowWinnerBanner({
    super.key,
    required this.gameController,
  });

  final GameController gameController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedScale(
        scale: gameController.playerWon.value != '' ? 1 : 0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          width: 300,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white),
          ),
          child: Obx(
            () => Text(
              gameController.getWinner(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
