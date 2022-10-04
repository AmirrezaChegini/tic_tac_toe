import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:tic_tac_toe/anim/left_to_right_anim.dart';
import 'package:tic_tac_toe/anim/right_to_left_anim.dart';
import 'package:tic_tac_toe/anim/scale_anim.dart';
import 'package:tic_tac_toe/anim/up_to_down_fade_anim.dart';

class GamePage extends StatefulWidget {
  const GamePage(
      {Key? key,
      required this.player1,
      required this.player2,
      required this.difficult})
      : super(key: key);

  final String player1;
  final String player2;
  final int difficult;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int playerTurn = 1;
  int player1Score = 0;
  int player2Score = 0;
  String playerWon = '';
  int tabs = 0;
  List<String> selects = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 50; i++) {
      selects.add('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(),
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
              child: Text(
                '${widget.player1} : $player1Score',
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
              child: Text(
                '${widget.player2} : $player2Score',
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
        child: Text(
          playerTurn == 1
              ? '${widget.player1} \'s TURN'
              : '${widget.player2} \'s TURN',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _getWon() {
    return ScaleAnim(
      isWin: playerWon != '' ? true : false,
      child: Container(
        width: 300,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white),
        ),
        child: Text(
          getWinner(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _getSquars() {
    if (widget.difficult == 0) {
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
                    onTap: () => gameRole(index),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ScaleAnim(
                        isWin: selects[index] != '' ? true : false,
                        child: selects[index] != ''
                            ? Image.asset('assets/images/${selects[index]}.png')
                            : SizedBox(),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    } else if (widget.difficult == 1) {
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
                    onTap: () => gameRole(index),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ScaleAnim(
                        isWin: selects[index] != '' ? true : false,
                        child: selects[index] != ''
                            ? Image.asset('assets/images/${selects[index]}.png')
                            : SizedBox(),
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
                    onTap: () => gameRole(index),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ScaleAnim(
                        isWin: selects[index] != '' ? true : false,
                        child: selects[index] != ''
                            ? Image.asset('assets/images/${selects[index]}.png')
                            : SizedBox(),
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
    return ScaleAnim(
      isWin: playerWon != '' ? true : false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () => resetMatch(),
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
            onPressed: () => resetGame(),
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
    );
  }

  void gameRole(int i) {
    setState(() {
      if (selects[i] == '' && playerWon == '') {
        tabs++;
        if (playerTurn == 1) {
          selects[i] = 'x';
          playerTurn = 2;
        } else {
          selects[i] = 'o';
          playerTurn = 1;
        }
      } else {
        return;
      }

      if (widget.difficult == 0) {
        checkWinner0();
      } else if (widget.difficult == 1) {
        checkWinner1();
      } else {
        checkWinner2();
      }

      UpdateScore();
    });
  }

  void checkWinner0() {
    if (selects[0] == selects[1] &&
        selects[0] == selects[2] &&
        selects[0] != '') {
      playerWon = selects[0];
    } else if (selects[3] == selects[4] &&
        selects[3] == selects[5] &&
        selects[3] != '') {
      playerWon = selects[3];
    } else if (selects[6] == selects[7] &&
        selects[6] == selects[8] &&
        selects[6] != '') {
      playerWon = selects[6];
    } else if (selects[0] == selects[3] &&
        selects[0] == selects[6] &&
        selects[0] != '') {
      playerWon = selects[0];
    } else if (selects[1] == selects[4] &&
        selects[1] == selects[7] &&
        selects[1] != '') {
      playerWon = selects[1];
    } else if (selects[2] == selects[5] &&
        selects[2] == selects[8] &&
        selects[2] != '') {
      playerWon = selects[2];
    } else if (selects[0] == selects[4] &&
        selects[0] == selects[8] &&
        selects[0] != '') {
      playerWon = selects[0];
    } else if (selects[2] == selects[4] &&
        selects[2] == selects[6] &&
        selects[2] != '') {
      playerWon = selects[2];
    } else if (tabs == 9) {
      resetMatch();
    }
  }

  void checkWinner1() {
    if (selects[0] == selects[1] &&
        selects[0] == selects[2] &&
        selects[0] == selects[3] &&
        selects[0] == selects[4] &&
        selects[0] != '') {
      playerWon = selects[0];
    } else if (selects[5] == selects[6] &&
        selects[5] == selects[7] &&
        selects[5] == selects[8] &&
        selects[5] == selects[9] &&
        selects[5] != '') {
      playerWon = selects[5];
    } else if (selects[10] == selects[11] &&
        selects[10] == selects[12] &&
        selects[10] == selects[13] &&
        selects[10] == selects[14] &&
        selects[10] != '') {
      playerWon = selects[10];
    } else if (selects[15] == selects[16] &&
        selects[15] == selects[17] &&
        selects[15] == selects[18] &&
        selects[15] == selects[19] &&
        selects[15] != '') {
      playerWon = selects[15];
    } else if (selects[20] == selects[21] &&
        selects[20] == selects[22] &&
        selects[20] == selects[23] &&
        selects[20] == selects[24] &&
        selects[20] != '') {
      playerWon = selects[20];
    } else if (selects[0] == selects[5] &&
        selects[0] == selects[10] &&
        selects[0] == selects[15] &&
        selects[0] == selects[20] &&
        selects[0] != '') {
      playerWon = selects[0];
    } else if (selects[1] == selects[6] &&
        selects[1] == selects[11] &&
        selects[1] == selects[16] &&
        selects[1] == selects[21] &&
        selects[1] != '') {
      playerWon = selects[1];
    } else if (selects[2] == selects[7] &&
        selects[2] == selects[12] &&
        selects[2] == selects[17] &&
        selects[2] == selects[22] &&
        selects[2] != '') {
      playerWon = selects[2];
    } else if (selects[3] == selects[8] &&
        selects[3] == selects[13] &&
        selects[3] == selects[18] &&
        selects[3] == selects[23] &&
        selects[3] != '') {
      playerWon = selects[3];
    } else if (selects[4] == selects[9] &&
        selects[4] == selects[14] &&
        selects[4] == selects[19] &&
        selects[4] == selects[24] &&
        selects[4] != '') {
      playerWon = selects[4];
    } else if (selects[0] == selects[6] &&
        selects[0] == selects[12] &&
        selects[0] == selects[18] &&
        selects[0] == selects[24] &&
        selects[0] != '') {
      playerWon = selects[0];
    } else if (selects[4] == selects[8] &&
        selects[4] == selects[12] &&
        selects[4] == selects[16] &&
        selects[4] == selects[20] &&
        selects[4] != '') {
      playerWon = selects[4];
    } else if (tabs == 25) {
      resetMatch();
    }
  }

  void checkWinner2() {
    if (selects[0] == selects[1] &&
        selects[0] == selects[2] &&
        selects[0] == selects[3] &&
        selects[0] == selects[4] &&
        selects[0] == selects[5] &&
        selects[0] == selects[6] &&
        selects[0] != '') {
      playerWon = selects[0];
    } else if (selects[7] == selects[8] &&
        selects[7] == selects[9] &&
        selects[7] == selects[10] &&
        selects[7] == selects[11] &&
        selects[7] == selects[12] &&
        selects[7] == selects[13] &&
        selects[7] != '') {
      playerWon = selects[7];
    } else if (selects[14] == selects[15] &&
        selects[14] == selects[16] &&
        selects[14] == selects[17] &&
        selects[14] == selects[18] &&
        selects[14] == selects[19] &&
        selects[14] == selects[20] &&
        selects[14] != '') {
      playerWon = selects[14];
    } else if (selects[21] == selects[22] &&
        selects[21] == selects[23] &&
        selects[21] == selects[24] &&
        selects[21] == selects[25] &&
        selects[21] == selects[26] &&
        selects[21] == selects[27] &&
        selects[21] != '') {
      playerWon = selects[21];
    } else if (selects[28] == selects[29] &&
        selects[28] == selects[30] &&
        selects[28] == selects[31] &&
        selects[28] == selects[32] &&
        selects[28] == selects[33] &&
        selects[28] == selects[34] &&
        selects[28] != '') {
      playerWon = selects[28];
    } else if (selects[35] == selects[36] &&
        selects[35] == selects[37] &&
        selects[35] == selects[38] &&
        selects[35] == selects[39] &&
        selects[35] == selects[40] &&
        selects[35] == selects[41] &&
        selects[35] != '') {
      playerWon = selects[35];
    } else if (selects[42] == selects[43] &&
        selects[42] == selects[44] &&
        selects[42] == selects[45] &&
        selects[42] == selects[46] &&
        selects[42] == selects[47] &&
        selects[42] == selects[48] &&
        selects[42] != '') {
      playerWon = selects[42];
    } else if (selects[0] == selects[7] &&
        selects[0] == selects[14] &&
        selects[0] == selects[21] &&
        selects[0] == selects[28] &&
        selects[0] == selects[35] &&
        selects[0] == selects[42] &&
        selects[0] != '') {
      playerWon = selects[0];
    } else if (selects[1] == selects[8] &&
        selects[1] == selects[15] &&
        selects[1] == selects[22] &&
        selects[1] == selects[29] &&
        selects[1] == selects[36] &&
        selects[1] == selects[43] &&
        selects[1] != '') {
      playerWon = selects[1];
    } else if (selects[2] == selects[9] &&
        selects[2] == selects[16] &&
        selects[2] == selects[23] &&
        selects[2] == selects[30] &&
        selects[2] == selects[37] &&
        selects[2] == selects[44] &&
        selects[2] != '') {
      playerWon = selects[2];
    } else if (selects[3] == selects[10] &&
        selects[3] == selects[17] &&
        selects[3] == selects[24] &&
        selects[3] == selects[31] &&
        selects[3] == selects[38] &&
        selects[3] == selects[45] &&
        selects[3] != '') {
      playerWon = selects[3];
    } else if (selects[4] == selects[11] &&
        selects[4] == selects[18] &&
        selects[4] == selects[25] &&
        selects[4] == selects[32] &&
        selects[4] == selects[39] &&
        selects[4] == selects[46] &&
        selects[4] != '') {
      playerWon = selects[4];
    } else if (selects[5] == selects[12] &&
        selects[5] == selects[19] &&
        selects[5] == selects[26] &&
        selects[5] == selects[33] &&
        selects[5] == selects[40] &&
        selects[5] == selects[47] &&
        selects[5] != '') {
      playerWon = selects[5];
    } else if (selects[6] == selects[13] &&
        selects[6] == selects[20] &&
        selects[6] == selects[27] &&
        selects[6] == selects[34] &&
        selects[6] == selects[41] &&
        selects[6] == selects[48] &&
        selects[6] != '') {
      playerWon = selects[6];
    } else if (selects[0] == selects[8] &&
        selects[0] == selects[16] &&
        selects[0] == selects[24] &&
        selects[0] == selects[32] &&
        selects[0] == selects[40] &&
        selects[0] == selects[48] &&
        selects[0] != '') {
      playerWon = selects[0];
    } else if (selects[6] == selects[12] &&
        selects[6] == selects[18] &&
        selects[6] == selects[24] &&
        selects[6] == selects[30] &&
        selects[6] == selects[36] &&
        selects[6] == selects[42] &&
        selects[6] != '') {
      playerWon = selects[6];
    } else if (tabs == 49) {
      resetMatch();
    }
  }

  String getWinner() {
    if (playerWon == 'x') {
      return '${widget.player1} WON game';
    } else if (playerWon == 'o') {
      return '${widget.player2} WON game';
    } else {
      return '';
    }
  }

  void UpdateScore() {
    if (playerWon == 'x') {
      player1Score++;
    } else if (playerWon == 'o') {
      player2Score++;
    }
  }

  void resetMatch() {
    setState(() {
      for (int i = 0; i < selects.length; i++) {
        selects[i] = '';
      }

      if (playerWon == 'x') {
        playerTurn = 1;
      } else if (playerWon == 'o') {
        playerTurn = 2;
      }
      playerWon = '';
      tabs = 0;
    });
  }

  void resetGame() {
    setState(() {
      for (int i = 0; i < selects.length; i++) {
        selects[i] = '';
      }
      playerTurn = 1;
      playerWon = '';
      tabs = 0;
      player1Score = 0;
      player2Score = 0;
    });
  }
}
