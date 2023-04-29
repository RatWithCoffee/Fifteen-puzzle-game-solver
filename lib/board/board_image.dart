import 'package:flutter/material.dart';

// класс для отображения плиток игровой доски
class BoardImage extends StatelessWidget {
  late final List<List<Tile>> tiles; // массив плиток

  BoardImage(List<List<int>> board, {super.key}) {
    tiles = [];
    for (List<int> row in board) {
      tiles.add(row.map((e) => Tile(e)).toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: tiles
              .map((row) => Row(
                    children: row,
                  ))
              .toList(),
        ));
  }
}

// плитка доски с числовым значением
class Tile extends StatelessWidget {
  final int number;

  const Tile(this.number, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child: Container(
        padding: const EdgeInsets.all(3),
        margin: const EdgeInsets.all(3),
        decoration: const BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Text(
          number.toString(),
          style: const TextStyle(
            fontSize: 25,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
