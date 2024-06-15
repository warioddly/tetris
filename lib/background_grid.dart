import 'package:flutter/material.dart';
import 'package:tetris/constants.dart';


class BackgroundGrid extends StatelessWidget {

  const BackgroundGrid({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height.floorToDouble(),
      width: size.width.roundToDouble(),
      child: CustomPaint(
        painter: GridPainter(),
      ),
    );
  }

}


class GridPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 0.5;

    for (int i = 0; i < size.width / kTileSize; i++) {
      canvas.drawLine(Offset(i * kTileSize, 0), Offset(i * kTileSize, size.height), paint);
    }

    for (int i = 0; i < size.height / kTileSize; i++) {
      canvas.drawLine(Offset(0, i * kTileSize), Offset(size.width, i * kTileSize), paint);
    }

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}
