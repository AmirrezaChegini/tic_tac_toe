import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/anim/left_to_right_anim.dart';
import 'package:tic_tac_toe/anim/right_to_left_anim.dart';
import 'package:tic_tac_toe/anim/scale_anim.dart';
import 'package:tic_tac_toe/anim/up_to_down_fade_anim.dart';
import 'package:tic_tac_toe/controller/app_ctrl.dart';

class GamePage extends StatelessWidget {
  final appCtrl = Get.put(AppCtrl());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        appCtrl.resetGame();
        return true;
      },
      child: Scaffold(
        body: _getBody(),
      ),
    );
  }

  Widget _getBody() {
    return DecoratedBox(
      position: DecorationPosition.background,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(flex: 8, child: _getScoreBoard()),
              SizedBox(height: 30),
              Expanded(flex: 8, child: _getTurn()),
              SizedBox(height: 10),
              Expanded(flex: 8, child: _getWon()),
              SizedBox(height: 30),
              Expanded(flex: 60, child: _getSquars()),
              Expanded(flex: 16, child: _getResetButtons()),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getScoreBoard() {
    return Row(
      children: [
        Expanded(
          child: LeftToRightAnim(
            milliSecond: 500,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white),
              ),
              child: Obx(
                () => Text(
                  '${appCtrl.edtP1Ctrl.text} : ${appCtrl.player1Score.value}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
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
          child: UpToDownFadeAnim(
            milliSecond: 0,
            child: Text(
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
          child: RightToLeftAnim(
            milliSecond: 500,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white),
              ),
              child: Obx(
                () => Text(
                  '${appCtrl.edtP2Ctrl.text} : ${appCtrl.player2Score.value}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
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

  Widget _getTurn() {
    return UpToDownFadeAnim(
      milliSecond: 1000,
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
            appCtrl.playerTurn.value == 1
                ? '${appCtrl.edtP1Ctrl.text} \'s TURN'
                : '${appCtrl.edtP2Ctrl.text} \'s TURN',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _getWon() {
    return Obx(
      () => ScaleAnim(
        isWin: appCtrl.playerWon.value != '' ? true : false,
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
              appCtrl.getWinner(),
              style: TextStyle(
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

  Widget _getSquars() {
    if (appCtrl.difficultSelected.value == 0) {
      return AnimationLimiter(
        child: GridView.builder(
          itemCount: 9,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 1300),
              columnCount: 3,
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: GestureDetector(
                    onTap: () => appCtrl.gameRole(index),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Obx(
                        () => ScaleAnim(
                          isWin: appCtrl.selects[index] != '' ? true : false,
                          child: appCtrl.selects[index] != ''
                              ? Image.asset(
                                  'assets/images/${appCtrl.selects[index]}.png')
                              : SizedBox(),
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
    } else if (appCtrl.difficultSelected.value == 1) {
      return AnimationLimiter(
        child: GridView.builder(
          itemCount: 25,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
          ),
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 1100),
              columnCount: 5,
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: GestureDetector(
                    onTap: () => appCtrl.gameRole(index),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Obx(
                        () => ScaleAnim(
                          isWin: appCtrl.selects[index] != '' ? true : false,
                          child: appCtrl.selects[index] != ''
                              ? Image.asset(
                                  'assets/images/${appCtrl.selects[index]}.png')
                              : SizedBox(),
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
    } else {
      return AnimationLimiter(
        child: GridView.builder(
          itemCount: 49,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
          ),
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 800),
              columnCount: 7,
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: GestureDetector(
                    onTap: () => appCtrl.gameRole(index),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Obx(
                        () => ScaleAnim(
                          isWin: appCtrl.selects[index] != '' ? true : false,
                          child: appCtrl.selects[index] != ''
                              ? Image.asset(
                                  'assets/images/${appCtrl.selects[index]}.png')
                              : SizedBox(),
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

  Widget _getResetButtons() {
    return Obx(
      () => ScaleAnim(
        isWin: appCtrl.playerWon.value != '' ? true : false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => appCtrl.resetMatch(),
              child: Text('Reset Match'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                side: BorderSide(
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(15),
              ),
            ),
            SizedBox(width: 20),
            TextButton(
              onPressed: () => appCtrl.resetGame(),
              child: Text('Reset Game'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                side: BorderSide(
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
