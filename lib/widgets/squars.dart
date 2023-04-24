import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/controller/game_controller.dart';

class Squars extends StatelessWidget {
  const Squars({
    super.key,
    required this.gameController,
  });

  final GameController gameController;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.builder(
        itemCount: gameController.difficultSelected.value == 0 ? 9 : 49,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gameController.difficultSelected.value == 0 ? 3 : 7,
        ),
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 600),
            columnCount: gameController.difficultSelected.value == 0 ? 3 : 7,
            child: ScaleAnimation(
              child: FadeInAnimation(
                child: GestureDetector(
                  onTap: () => gameController.gameRole(index),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Obx(
                      () => AnimatedScale(
                        scale: gameController.selects[index] != '' ? 1 : 0,
                        duration: const Duration(milliseconds: 300),
                        child: gameController.selects[index] != ''
                            ? Image.asset(
                                'assets/images/${gameController.selects[index]}.png')
                            : const SizedBox(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
