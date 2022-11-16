import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/anim/up_to_down_fade_anim.dart';
import 'package:tic_tac_toe/controller/app_ctrl.dart';
import 'package:tic_tac_toe/pages/game_page.dart';

class LoginPage extends StatelessWidget {
  final appCtrl = Get.put(AppCtrl());
  final List<String> difficulty = ['Easy', 'Medium', 'Hard'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _getBody(context),
    );
  }

  Widget _getBody(BuildContext context) {
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
            UpToDownFadeAnim(
              milliSecond: 500,
              child: Text(
                'Players Name',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            _getEdtPlayerForm(),
            SizedBox(height: 40),
            UpToDownFadeAnim(
              milliSecond: 2000,
              child: Text(
                'Choose Difficulty',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            _getPlayStyle(context),
          ],
        ),
      ),
    );
  }

  Widget _getEdtPlayerForm() {
    return Form(
      key: appCtrl.edtFormKey,
      child: Column(
        children: [
          UpToDownFadeAnim(
            milliSecond: 1000,
            child: TextFormField(
              controller: appCtrl.edtP1Ctrl,
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
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name!!';
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 15),
          UpToDownFadeAnim(
            milliSecond: 1500,
            child: TextFormField(
              controller: appCtrl.edtP2Ctrl,
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
                  borderSide:
                      BorderSide(color: Color.fromRGBO(255, 255, 255, 1)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name!!';
                } else if (value == appCtrl.edtP1Ctrl.text) {
                  return 'Choose different name!!';
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget _getPlayStyle(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
          3,
          (index) {
            return UpToDownFadeAnim(
              milliSecond: 2500,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Obx(
                  () => ListTile(
                    onTap: () {
                      appCtrl.difficultSelected.value = index;
                    },
                    title: Text(difficulty[index]),
                    textColor: Colors.white,
                    trailing: Icon(
                      appCtrl.difficultSelected.value == index
                          ? Icons.circle
                          : Icons.circle_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(height: 50),
        UpToDownFadeAnim(
          milliSecond: 3000,
          child: TextButton(
            onPressed: () => playGame(context),
            child: Text('Play'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              side: BorderSide(color: Colors.white),
              textStyle: TextStyle(fontSize: 22),
              minimumSize: Size(100, 40),
            ),
          ),
        ),
      ],
    );
  }

  void playGame(BuildContext context) {
    if (appCtrl.difficultSelected.value != 4 &&
        appCtrl.edtFormKey.currentState!.validate()) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => GamePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero)
                  .animate(animation),
              child: child,
            );
          },
        ),
      );
    }
  }
}
