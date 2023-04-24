import 'package:flutter/material.dart';
import 'package:tic_tac_toe/controller/game_controller.dart';
import 'package:tic_tac_toe/widgets/reset_btns.dart';
import 'package:tic_tac_toe/widgets/score_board.dart';
import 'package:tic_tac_toe/widgets/show_turn_banner.dart';
import 'package:tic_tac_toe/widgets/show_winner_banner.dart';
import 'package:tic_tac_toe/widgets/squars.dart';

class GamePage extends StatelessWidget {
  const GamePage({
    super.key,
    required this.gameController,
  });

  final GameController gameController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        gameController.resetGame();
        return true;
      },
      child: Scaffold(
        body: DecoratedBox(
          position: DecorationPosition.background,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: ScoreBoard(gameController: gameController),
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    flex: 8,
                    child: ShowTurnBanner(gameController: gameController),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    flex: 8,
                    child: ShowWinnerBanner(gameController: gameController),
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    flex: 60,
                    child: Squars(gameController: gameController),
                  ),
                  Expanded(
                    flex: 16,
                    child: RestetBtns(gameController: gameController),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
