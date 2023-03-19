import 'package:flutter/material.dart';
import 'style.dart';

Widget userImage(String imgURL) {
  return Container(
    padding: EdgeInsets.all(2),
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      child: Image.network(
        imgURL,
        width: 30,
        height: 30,
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget profileBox(List<String> proflies) {
  return Row(
    children:
        List.generate(proflies.length, (index) => userImage(proflies[index])),
  );
}
