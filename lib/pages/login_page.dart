import 'package:flutter/material.dart';
import 'package:tic_tac_toe/pages/game_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var player1Crtl = TextEditingController();
  var player2Crtl = TextEditingController();
  String? player1;
  String? player2;
  String? error;
  List<String> difficulty = ['Easy', 'Medium', 'Hard'];
  int? difficult;
  List<IconData> cardIcons = [
    Icons.circle_outlined,
    Icons.circle_outlined,
    Icons.circle_outlined
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Players Name',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            _getEdtPlayer(),
            SizedBox(height: 40),
            Text(
              'Choose Difficulty',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            _getPlayStyle(),
          ],
        ),
      ),
    );
  }

  Widget _getEdtPlayer() {
    return Column(
      children: [
        TextFormField(
          controller: player1Crtl,
          cursorColor: Colors.white,
          keyboardType: TextInputType.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          decoration: InputDecoration(
            labelText: 'Player 1',
            labelStyle: TextStyle(color: Colors.white),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            errorText: error,
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        ),
        SizedBox(height: 15),
        TextFormField(
          controller: player2Crtl,
          cursorColor: Colors.white,
          keyboardType: TextInputType.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          decoration: InputDecoration(
            labelText: 'Player 2',
            labelStyle: TextStyle(color: Colors.white),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            errorText: error,
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        ),
        SizedBox(height: 25),
      ],
    );
  }

  Widget _getPlayStyle() {
    return Column(
      children: [
        ...List.generate(
          3,
          (index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(4),
              ),
              child: ListTile(
                onTap: () {
                  setState(() {
                    difficult = index;

                    if (index == 0) {
                      cardIcons[0] = Icons.circle;
                      cardIcons[1] = Icons.circle_outlined;
                      cardIcons[2] = Icons.circle_outlined;
                    } else if (index == 1) {
                      cardIcons[0] = Icons.circle_outlined;
                      cardIcons[1] = Icons.circle;
                      cardIcons[2] = Icons.circle_outlined;
                    } else if (index == 2) {
                      cardIcons[0] = Icons.circle_outlined;
                      cardIcons[1] = Icons.circle_outlined;
                      cardIcons[2] = Icons.circle;
                    } else {
                      cardIcons[0] = Icons.circle_outlined;
                      cardIcons[1] = Icons.circle_outlined;
                      cardIcons[2] = Icons.circle_outlined;
                    }
                  });
                },
                title: Text(difficulty[index]),
                textColor: Colors.white,
                trailing: Icon(
                  cardIcons[index],
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
        SizedBox(height: 50),
        TextButton(
          onPressed: () => playGame(),
          child: Text('Play'),
          style: TextButton.styleFrom(
            primary: Colors.white,
            side: BorderSide(color: Colors.white),
            textStyle: TextStyle(fontSize: 22),
            minimumSize: Size(100, 40),
          ),
        ),
      ],
    );
  }

  void playGame() {
    setState(() {
      player1 = player1Crtl.text.toString();
      player2 = player2Crtl.text.toString();

      if (player1 == '' || player2 == '') {
        error = 'Please enter your name!!';
      } else if (player1 == player2) {
        error = 'Do NOT use same name!!';
      }else{
        error = null;
      }

      if(difficult != null && error == null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GamePage(
              player1: player1!,
              player2: player2!,
              difficult: difficult!,
            ),
          ),
        );
      }
    });
  }
}
