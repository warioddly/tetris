import 'dart:async';

import 'package:flutter/material.dart' hide Hero;
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:tetris/background_grid.dart';
import 'package:tetris/constants.dart';
import 'package:tetris/shapes.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tetris',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  Shape? currentShape;


  Duration interval = const Duration(milliseconds: 500);
  Timer? timer;

  Size size = const Size(0, 0);

  final shapes = <Shape>[];


  @override
  void initState() {
    super.initState();

    shapes.add(currentShape = randomShape());
    timer = Timer.periodic(interval, ticker);

  }


  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Tetris"),
      ),
      body: KeyboardListener(
        focusNode: FocusNode()..requestFocus(),
        onKeyEvent: onKeyEvent,
        child: Stack(
          children: <Widget>[
            BackgroundGrid(size: size),

            Positioned(
              top: currentShape!.position.y.toDouble(),
              left: currentShape!.position.x.toDouble(),
              child: currentShape!.render(),
            ),

            ...shapes.map((shape) => Positioned(
              top: shape.position.y.toDouble(),
              left: shape.position.x.toDouble(),
              child: shape.render(),
            )),

            // BlueRicky(),
            // ClevelandZ(),
            // RhodeIslandZ(),
            // Hero(),
            // Teewee(),
            // Smashboy(),
          ],
        ),
      ),
    );
  }


  void onKeyEvent(KeyEvent event) {

    if (event is KeyDownEvent) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.arrowLeft:
          currentShape?.position.x -= kTileSize.toInt();
          break;
        case LogicalKeyboardKey.arrowRight:
          currentShape?.position.x += kTileSize.toInt();
          break;
        case LogicalKeyboardKey.arrowDown:
          currentShape?.position.y += kTileSize.toInt();
          break;
        case LogicalKeyboardKey.space:
          currentShape?.rotate();
          break;
        case LogicalKeyboardKey.enter:
          final shape = randomShape();
          shape.position.x = currentShape!.position.x;
          shape.position.y = currentShape!.position.y;
          currentShape = shape;
          break;
        default:
          break;
      }
    }

    updateState();
  }


  Shape randomShape() {
    return switch(DateTime.now().millisecond % 6) {
      0 => BlueRicky(),
      1 => ClevelandZ(),
      2 => RhodeIslandZ(),
      3 => Hero(),
      4 => Teewee(),
      5 => Smashboy(),
      _ => BlueRicky(),
    };
  }


  void ticker(timer) {

    currentShape?.position.y += kTileSize.toInt();

    if (currentShape!.position.y >= size.height) {
      currentShape = randomShape();
      shapes.add(currentShape!);
    }

    updateState();
  }


  void updateState([VoidCallback? fn]) {
    if (mounted) {
      setState(fn ?? () {});
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

}
