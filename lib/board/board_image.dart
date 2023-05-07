import 'package:flutter/material.dart';

// класс для отображения плиток игровой доски
class BoardImage extends StatelessWidget {
  final List<List<int>> board;
  final int move;

  const BoardImage(this.board, this.move, {super.key});

  @override
  Widget build(BuildContext context) {
    List<List<Tile>> tiles = []; // массив плиток
    for (List<int> row in board) {
      tiles.add(row.map((e) => Tile(e)).toList());
    }

    return Container(
        margin: const EdgeInsets.only(bottom: 5, right: 20, top: 10, left: 20),
        padding:
            const EdgeInsets.only(bottom: 10, right: 15, top: 10, left: 10),
        decoration: const BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                children: tiles
                    .map((row) => Row(
                          children: row,
                        ))
                    .toList(),
              ),
            ),
            Expanded(
                flex: 1,
                child:
                    Container(alignment: Alignment.topRight, child: Tile(move)))
          ],
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
