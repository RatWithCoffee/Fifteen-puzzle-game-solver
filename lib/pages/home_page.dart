import 'dart:math';

import 'package:flutter/material.dart';
import 'package:puzzle/board/board_validation.dart';

import '../solution_algorithm/find_solution.dart';
import 'info_pop_up_window.dart';

// главная станица с полями для ввода значений
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int dim = 3; // размерность доски
  late List<String> initBoard; // список введенных значений клеток

  _HomePageState() {
    initBoard = List.filled(pow(dim, 2) as int, '');
  }

  @override
  Widget build(BuildContext context) {
    List<List<Widget>> inputTiles =
        []; // массив текстовых полей для ввода значений клеток

    // заполняем массив текстовыми полями
    for (int i = 0; i < dim; i++) {
      inputTiles.add([]);
      for (int j = 0; j < dim; j++) {
        inputTiles[i].add(SizedBox(
            width: 80,
            height: 80,
            child: Container(
              margin: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextField(
                onChanged: (text) => initBoard[i * dim + j] = text,
                keyboardType: TextInputType.number,
                maxLength: 2,
                style: const TextStyle(
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                    counter: Offstage(), border: InputBorder.none),
              ),
            )));
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Пятнашки'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              showDialog<void>(
                  context: context,
                  builder: (BuildContext context) => const InfoButton());
            },
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 10, top: 30, right: 10),
        padding: const EdgeInsets.all(40),
        decoration: const BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: inputTiles
                .map((row) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: row,
                    ))
                .toList()),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          List<List<int>>? resBoard = BoardValidation.getResBoard(
              initBoard, dim, context); // проверяем и преобразуем значения
          if (resBoard != null) {
            // все введено правильно -> передаем введенные пятнашки на страницу с их решением и выводом ответа
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FindSolution(resBoard)));
          }
        },
        label: const Text('Решить'),
      ),
    );
  }
}
