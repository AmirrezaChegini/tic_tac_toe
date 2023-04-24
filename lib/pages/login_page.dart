import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/controller/game_controller.dart';
import 'package:tic_tac_toe/pages/game_page.dart';
import 'package:tic_tac_toe/widgets/custom_list_tile.dart';
import 'package:tic_tac_toe/widgets/edt_text.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final GameController _gameController = Get.put(GameController());
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final List<String> difficults = const ['Easy', 'Hard'];

  void playGame(BuildContext context) {
    if (_globalKey.currentState!.validate()) {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => GamePage(gameController: _gameController),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DecoratedBox(
        position: DecorationPosition.background,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DelayedWidget(
                animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                delayDuration: const Duration(milliseconds: 200),
                child: const Text(
                  'Players Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Form(
                key: _globalKey,
                child: Column(
                  children: [
                    DelayedWidget(
                      animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                      delayDuration: const Duration(milliseconds: 400),
                      child: EdtText(
                        label: 'Player 1',
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'please enter your name!';
                          }
                          _gameController.playerName1 = value;
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    DelayedWidget(
                      animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                      delayDuration: const Duration(milliseconds: 600),
                      child: EdtText(
                        label: 'Player 2',
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'please enter your name!';
                          }
                          _gameController.playerName2 = value;
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              DelayedWidget(
                animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                delayDuration: const Duration(milliseconds: 800),
                child: const Text(
                  'Choose Difficulty',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              ...List.generate(
                difficults.length,
                (index) {
                  return DelayedWidget(
                    animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                    delayDuration:
                        Duration(milliseconds: int.parse('1${2 * index}00')),
                    child: CustomListTile(
                      index: index,
                      difficults: difficults,
                      gameController: _gameController,
                    ),
                  );
                },
              ),
              const SizedBox(height: 50),
              DelayedWidget(
                animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                delayDuration: const Duration(milliseconds: 1400),
                child: TextButton(
                  onPressed: () => playGame(context),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    textStyle: const TextStyle(fontSize: 22),
                    minimumSize: const Size(100, 40),
                  ),
                  child: const Text('Play'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
