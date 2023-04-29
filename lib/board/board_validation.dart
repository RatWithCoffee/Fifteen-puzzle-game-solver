import 'dart:math';

import 'package:flutter/material.dart';

// для проверки введённых пользователем значений к клетках
// если что-то не так, то отображается сообщение об ошибке внизу экрана
class BoardValidation {
  // функция проверяет введённые значения и возвращает их в числовом формате, если все ок
  // иначе возвращает null
  static List<List<int>>? getResBoard(
      List<String> initBoard, int dim, BuildContext context) {
    List<List<int>> resBoard = [];
    bool hasEmptyTile = false;
    // цикл проверяет все значения в массиве
    for (int i = 0; i < dim; i++) {
      resBoard.add([]);
      for (int j = 0; j < dim; j++) {
        if (initBoard[i * dim + j] == "") {
          // пустая клетка
          resBoard[i].add(0);
          hasEmptyTile = true;
        } else {
          // в клетке есть значение
          if (_isValid(initBoard[i * dim + j], dim)) {
            // введённое значение прошло все проверки -> добавляем его в возвращаемый список
            resBoard[i].add(num.parse(initBoard[i * dim + j]) as int);
          } else {
            // ошибка ввода
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.teal,
                content: Text(
                  'Нужно ввести целые неотрицательные числа от 1 до ${pow(dim, 2) - 1}',
                )));
            return null;
          }
        }
      }
    }

    if (!hasEmptyTile) {
      // нет пустых клеток
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.teal,
          content: Text('Должна быть ровно одна пустая клетка')));
      return null;
    }

    // проверка на повторяющиеся значения
    Set<int> uniqueNumbers = {};
    for (List<int> row in resBoard) {
      uniqueNumbers.addAll(row);
    }
    if (uniqueNumbers.length != pow(dim, 2)) {
      // есть повторяющиеся значения
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.teal,
          content:
              Text('Не должно быть повторяющихся пустых клеток и значений')));
      return null;
    }
    return resBoard;
  }

  // проверяет введённое в клетку значение
  static bool _isValid(String value, int dim) {
    if (num.tryParse(value) == null) {
      // значение не может быть преобразовано в число
      return false;
    }

    num n = num.parse(value);
    return (n is int && n >= 0 && n < pow(dim, 2));
  }
}
