import 'package:flutter/material.dart';
import 'style.dart';

Widget userImage(String imgURL, double size) {
  return Container(
    padding: EdgeInsets.all(2),
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(size/2)),
      child: Image.network(
        imgURL,
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget profileBox(List<String> proflies) {
  return Row(
    children:
        List.generate(proflies.length, (index) => userImage(proflies[index], 30)),
  );
}
