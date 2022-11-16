import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppCtrl extends GetxController {
  var playerTurn = 1.obs;
  var player1Score = 0.obs;
  var player2Score = 0.obs;
  var playerWon = ''.obs;
  var tabs = 0.obs;
  var selects = [].obs;
  final AudioPlayer audioPlayer = AudioPlayer();
  final edtP1Ctrl = TextEditingController();
  final edtP2Ctrl = TextEditingController();
  final edtFormKey = GlobalKey<FormState>();
  var difficultSelected = 4.obs;

  @override
  void onReady() async {
    await audioPlayer.setSource(AssetSource('sounds/carefree.mp3'));
    await audioPlayer.resume();
    for (int i = 0; i < 50; i++) {
      selects.add('');
    }
    super.onReady();
  }

  @override
  void dispose() {
    edtP1Ctrl.dispose();
    edtP2Ctrl.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  void gameRole(int i) {
    if (selects[i] == '' && playerWon.value == '') {
      tabs.value++;
      if (playerTurn.value == 1) {
        selects[i] = 'x';
        playerTurn.value = 2;
      } else {
        selects[i] = 'o';
        playerTurn.value = 1;
      }
    } else {
      return;
    }

    if (difficultSelected.value == 0) {
      checkWinner0();
    } else if (difficultSelected.value == 1) {
      checkWinner1();
    } else {
      checkWinner2();
    }

    UpdateScore();
  }

  void checkWinner0() {
    if (selects[0] == selects[1] &&
        selects[0] == selects[2] &&
        selects[0] != '') {
      playerWon.value = selects[0];
    } else if (selects[3] == selects[4] &&
        selects[3] == selects[5] &&
        selects[3] != '') {
      playerWon.value = selects[3];
    } else if (selects[6] == selects[7] &&
        selects[6] == selects[8] &&
        selects[6] != '') {
      playerWon.value = selects[6];
    } else if (selects[0] == selects[3] &&
        selects[0] == selects[6] &&
        selects[0] != '') {
      playerWon.value = selects[0];
    } else if (selects[1] == selects[4] &&
        selects[1] == selects[7] &&
        selects[1] != '') {
      playerWon.value = selects[1];
    } else if (selects[2] == selects[5] &&
        selects[2] == selects[8] &&
        selects[2] != '') {
      playerWon.value = selects[2];
    } else if (selects[0] == selects[4] &&
        selects[0] == selects[8] &&
        selects[0] != '') {
      playerWon.value = selects[0];
    } else if (selects[2] == selects[4] &&
        selects[2] == selects[6] &&
        selects[2] != '') {
      playerWon.value = selects[2];
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
      playerWon.value = selects[0];
    } else if (selects[5] == selects[6] &&
        selects[5] == selects[7] &&
        selects[5] == selects[8] &&
        selects[5] == selects[9] &&
        selects[5] != '') {
      playerWon.value = selects[5];
    } else if (selects[10] == selects[11] &&
        selects[10] == selects[12] &&
        selects[10] == selects[13] &&
        selects[10] == selects[14] &&
        selects[10] != '') {
      playerWon.value = selects[10];
    } else if (selects[15] == selects[16] &&
        selects[15] == selects[17] &&
        selects[15] == selects[18] &&
        selects[15] == selects[19] &&
        selects[15] != '') {
      playerWon.value = selects[15];
    } else if (selects[20] == selects[21] &&
        selects[20] == selects[22] &&
        selects[20] == selects[23] &&
        selects[20] == selects[24] &&
        selects[20] != '') {
      playerWon.value = selects[20];
    } else if (selects[0] == selects[5] &&
        selects[0] == selects[10] &&
        selects[0] == selects[15] &&
        selects[0] == selects[20] &&
        selects[0] != '') {
      playerWon.value = selects[0];
    } else if (selects[1] == selects[6] &&
        selects[1] == selects[11] &&
        selects[1] == selects[16] &&
        selects[1] == selects[21] &&
        selects[1] != '') {
      playerWon.value = selects[1];
    } else if (selects[2] == selects[7] &&
        selects[2] == selects[12] &&
        selects[2] == selects[17] &&
        selects[2] == selects[22] &&
        selects[2] != '') {
      playerWon.value = selects[2];
    } else if (selects[3] == selects[8] &&
        selects[3] == selects[13] &&
        selects[3] == selects[18] &&
        selects[3] == selects[23] &&
        selects[3] != '') {
      playerWon.value = selects[3];
    } else if (selects[4] == selects[9] &&
        selects[4] == selects[14] &&
        selects[4] == selects[19] &&
        selects[4] == selects[24] &&
        selects[4] != '') {
      playerWon.value = selects[4];
    } else if (selects[0] == selects[6] &&
        selects[0] == selects[12] &&
        selects[0] == selects[18] &&
        selects[0] == selects[24] &&
        selects[0] != '') {
      playerWon.value = selects[0];
    } else if (selects[4] == selects[8] &&
        selects[4] == selects[12] &&
        selects[4] == selects[16] &&
        selects[4] == selects[20] &&
        selects[4] != '') {
      playerWon.value = selects[4];
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
      playerWon.value = selects[0];
    } else if (selects[7] == selects[8] &&
        selects[7] == selects[9] &&
        selects[7] == selects[10] &&
        selects[7] == selects[11] &&
        selects[7] == selects[12] &&
        selects[7] == selects[13] &&
        selects[7] != '') {
      playerWon.value = selects[7];
    } else if (selects[14] == selects[15] &&
        selects[14] == selects[16] &&
        selects[14] == selects[17] &&
        selects[14] == selects[18] &&
        selects[14] == selects[19] &&
        selects[14] == selects[20] &&
        selects[14] != '') {
      playerWon.value = selects[14];
    } else if (selects[21] == selects[22] &&
        selects[21] == selects[23] &&
        selects[21] == selects[24] &&
        selects[21] == selects[25] &&
        selects[21] == selects[26] &&
        selects[21] == selects[27] &&
        selects[21] != '') {
      playerWon.value = selects[21];
    } else if (selects[28] == selects[29] &&
        selects[28] == selects[30] &&
        selects[28] == selects[31] &&
        selects[28] == selects[32] &&
        selects[28] == selects[33] &&
        selects[28] == selects[34] &&
        selects[28] != '') {
      playerWon.value = selects[28];
    } else if (selects[35] == selects[36] &&
        selects[35] == selects[37] &&
        selects[35] == selects[38] &&
        selects[35] == selects[39] &&
        selects[35] == selects[40] &&
        selects[35] == selects[41] &&
        selects[35] != '') {
      playerWon.value = selects[35];
    } else if (selects[42] == selects[43] &&
        selects[42] == selects[44] &&
        selects[42] == selects[45] &&
        selects[42] == selects[46] &&
        selects[42] == selects[47] &&
        selects[42] == selects[48] &&
        selects[42] != '') {
      playerWon.value = selects[42];
    } else if (selects[0] == selects[7] &&
        selects[0] == selects[14] &&
        selects[0] == selects[21] &&
        selects[0] == selects[28] &&
        selects[0] == selects[35] &&
        selects[0] == selects[42] &&
        selects[0] != '') {
      playerWon.value = selects[0];
    } else if (selects[1] == selects[8] &&
        selects[1] == selects[15] &&
        selects[1] == selects[22] &&
        selects[1] == selects[29] &&
        selects[1] == selects[36] &&
        selects[1] == selects[43] &&
        selects[1] != '') {
      playerWon.value = selects[1];
    } else if (selects[2] == selects[9] &&
        selects[2] == selects[16] &&
        selects[2] == selects[23] &&
        selects[2] == selects[30] &&
        selects[2] == selects[37] &&
        selects[2] == selects[44] &&
        selects[2] != '') {
      playerWon.value = selects[2];
    } else if (selects[3] == selects[10] &&
        selects[3] == selects[17] &&
        selects[3] == selects[24] &&
        selects[3] == selects[31] &&
        selects[3] == selects[38] &&
        selects[3] == selects[45] &&
        selects[3] != '') {
      playerWon.value = selects[3];
    } else if (selects[4] == selects[11] &&
        selects[4] == selects[18] &&
        selects[4] == selects[25] &&
        selects[4] == selects[32] &&
        selects[4] == selects[39] &&
        selects[4] == selects[46] &&
        selects[4] != '') {
      playerWon.value = selects[4];
    } else if (selects[5] == selects[12] &&
        selects[5] == selects[19] &&
        selects[5] == selects[26] &&
        selects[5] == selects[33] &&
        selects[5] == selects[40] &&
        selects[5] == selects[47] &&
        selects[5] != '') {
      playerWon.value = selects[5];
    } else if (selects[6] == selects[13] &&
        selects[6] == selects[20] &&
        selects[6] == selects[27] &&
        selects[6] == selects[34] &&
        selects[6] == selects[41] &&
        selects[6] == selects[48] &&
        selects[6] != '') {
      playerWon.value = selects[6];
    } else if (selects[0] == selects[8] &&
        selects[0] == selects[16] &&
        selects[0] == selects[24] &&
        selects[0] == selects[32] &&
        selects[0] == selects[40] &&
        selects[0] == selects[48] &&
        selects[0] != '') {
      playerWon.value = selects[0];
    } else if (selects[6] == selects[12] &&
        selects[6] == selects[18] &&
        selects[6] == selects[24] &&
        selects[6] == selects[30] &&
        selects[6] == selects[36] &&
        selects[6] == selects[42] &&
        selects[6] != '') {
      playerWon.value = selects[6];
    } else if (tabs == 49) {
      resetMatch();
    }
  }

  String getWinner() {
    if (playerWon.value == 'x') {
      return '${edtP1Ctrl.text} WON game';
    } else if (playerWon.value == 'o') {
      return '${edtP2Ctrl.text} WON game';
    } else {
      return '';
    }
  }

  void UpdateScore() {
    if (playerWon.value == 'x') {
      player1Score.value++;
    } else if (playerWon.value == 'o') {
      player2Score.value++;
    }
  }

  void resetGame() {
    for (int i = 0; i < selects.length; i++) {
      selects[i] = '';
    }
    playerTurn.value = 1;
    playerWon.value = '';
    tabs.value = 0;
    player1Score.value = 0;
    player2Score.value = 0;
  }

  void resetMatch() {
    for (int i = 0; i < selects.length; i++) {
      selects[i] = '';
    }

    if (playerWon.value == 'x') {
      playerTurn.value = 1;
    } else if (playerWon.value == 'o') {
      playerTurn.value = 2;
    }
    playerWon.value = '';
    tabs.value = 0;
  }
}
