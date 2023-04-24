import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/controller/game_controller.dart';

class RestetBtns extends StatelessWidget {
  const RestetBtns({
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => gameController.resetMatch(),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(15),
              ),
              child: const Text('Reset Match'),
            ),
            const SizedBox(width: 20),
            TextButton(
              onPressed: () => gameController.resetGame(),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(15),
              ),
              child: const Text('Reset Game'),
            ),
          ],
        ),
      ),
    );
  }
}
