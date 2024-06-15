import 'package:flutter/material.dart';
import 'package:tetris/square.dart';
import 'package:tetris/vector2.dart';



class Block extends StatelessWidget {

  const Block({super.key, required this.shape});

  final List<List<int>> shape;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [

        for (int i = 0; i < shape.length; i++) ...[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [

              for (int j = 0; j < shape[i].length; j++) ...[
                Square(color: shape[i][j] == 0 ? Colors.transparent : Colors.red),
              ],

            ],
          )
        ]
      ],

    );
  }

}


class Shape {


  Shape(this.shape) {
    render();
  }


  final List<List<int>> shape;


  final Vector2 position = Vector2(0, 0);


  Block? _block;


  Widget render() => _block = Block(shape: shape);


  void rotate() {
    final List<List<int>> newShape = List.generate(shape[0].length, (index) => List.filled(shape.length, 0));

    for (int i = 0; i < shape.length; i++) {
      for (int j = 0; j < shape[i].length; j++) {
        newShape[j][shape.length - i - 1] = shape[i][j];
      }
    }

    shape.clear();
    shape.addAll(newShape);

    render();
  }

}


class OrangeRicky extends Shape {

  OrangeRicky() : super([
    [1, 0, 0],
    [1, 1, 1]
  ]);

}


class BlueRicky extends Shape {

   BlueRicky() : super([
    [0, 0, 1],
    [1, 1, 1],
  ]);

}


class ClevelandZ extends Shape {

   ClevelandZ() : super([
    [1, 1, 0],
    [0, 1, 1],
  ]);

}


class RhodeIslandZ extends Shape {

  RhodeIslandZ() : super([
    [0, 1, 1],
    [1, 1, 0],
  ]);

}


class Hero extends Shape {

  Hero() : super([
    [1, 1, 1, 1],
  ]);

}


class Teewee extends Shape {

  Teewee() : super([
    [0, 1, 0],
    [1, 1, 1],
  ]);

}


class Smashboy extends Shape {

  Smashboy() : super([
    [1, 1],
    [1, 1]
  ]);

}
