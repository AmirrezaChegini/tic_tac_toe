import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/pages/login_page.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  runApp(Main());
}

class Main extends StatelessWidget {
  final AudioPlayer audioPlayer = AudioPlayer();

  void playMusic() async {
    await audioPlayer.setSource(AssetSource('sounds/carefree.mp3'));
    while (true) {
      await audioPlayer.resume();
    }
  }

  @override
  Widget build(BuildContext context) {
    playMusic();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
