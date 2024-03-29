import 'package:flutter/material.dart';
import 'board_card.dart';
import 'style.dart';

class AllBoardPage extends StatelessWidget {
  Widget squareButton(Icon icon, Color color, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 50,
        height: 50,
        color: color,
        child: Center(
          child: Icon(icon as IconData?, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Board'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BoardCard(
                boardName: "boardName",
                imageURLlist: [demoUserImage1, demoUserImage1],
                emailURLlist: ["a@a.com", "a@a.com"]),
            BoardCard(
                boardName: "board_Name",
                imageURLlist: [demoUserImage1, demoUserImage1],
                emailURLlist: ["a@a.com", "a@a.com"])
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
