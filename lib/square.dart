import 'package:flutter/material.dart';
import 'package:tetris/constants.dart';


class Square extends StatelessWidget {

  const Square({super.key, this.color = Colors.red});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kTileSize,
      height: kTileSize,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.black,
          width: 0.3,
        ),
      )
    );
  }
}