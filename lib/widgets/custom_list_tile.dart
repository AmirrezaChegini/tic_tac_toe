import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/controller/game_controller.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key,
      required this.index,
      required this.difficults,
      required this.gameController});
  final List<String> difficults;
  final int index;
  final GameController gameController;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Obx(
          () => ListTile(
            onTap: () => gameController.difficultSelected.value = index,
            title: Text(difficults[index]),
            textColor: Colors.white,
            trailing: Icon(
              gameController.difficultSelected.value == index
                  ? Icons.circle
                  : Icons.circle_outlined,
              color: Colors.white,
            ),
          ),
        ));
  }
}
