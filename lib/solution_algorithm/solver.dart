import 'package:collection/collection.dart';

import 'board.dart';

// класс для решения пятнашек с использованием алгоритма А*
class Solver {
  late List<Board> _shortestSolution; // список ходов в кратчайшем решении

  bool _isSolvable = true; // решаема ли головоломка

  Solver(Board initial) {
    int currMove = 0; // номер текущего шага
    int currMoveTwin = 0;

    // инициализация приоритетной очереди для переданных в конструктор пятнашек
    PriorityQueue<_SearchNode> nodes =
        PriorityQueue(_SearchNode.nodeComparator);
    nodes.add(_SearchNode(initial, currMove, null));
    // инициализация приоритетной очереди для вторых пятнашек,
    // полученных перестановкой двух непустых плиток в исходной головоломке
    PriorityQueue<_SearchNode> nodesTwin =
        PriorityQueue(_SearchNode.nodeComparator);
    nodesTwin.add(_SearchNode(initial.twin(), currMoveTwin, null));

    _SearchNode? parentNode; // main puzzle
    _SearchNode? grandparentNode;
    _SearchNode? parentNodeTwin; // twin puzzle
    _SearchNode? grandparentNodeTwin;
    // ищем ход решения или выясняем, что решения нет
    while (!nodes.first._board.isGoal()) {
      // удаляем из очереди доску с наибольшим приоритетом
      parentNode = nodes.removeFirst();
      currMove = parentNode._moves + 1;
      grandparentNode = parentNode._prevSearchNode;

      parentNodeTwin = nodesTwin.removeFirst();
      currMoveTwin = parentNodeTwin._moves + 1;
      grandparentNodeTwin = parentNodeTwin._prevSearchNode;

      // добавляем соседние доски в приоритетную очередь
      for (Board neighbor in parentNode._board.neighbors()) {
        // не добавляем в очередь повторы
        if (grandparentNode == null || grandparentNode._board != neighbor) {
          nodes.add(_SearchNode(neighbor, currMove, parentNode));
        }
      }

      for (Board neighbor in parentNodeTwin._board.neighbors()) {
        // не добавляем в очередь повторы
        if (grandparentNodeTwin == null ||
            grandparentNodeTwin._board != neighbor) {
          nodesTwin.add(_SearchNode(neighbor, currMoveTwin, parentNodeTwin));
        }
      }

      // если вторая доска нашла решение, то значит первая его не имеет
      if (nodesTwin.first._board.isGoal()) {
        _isSolvable = false;
        return;
      }
    }

    // решение есть -> создаем массив ходов в кратчайшем решении
    parentNode = nodes.first;
    _shortestSolution = [];
    while (parentNode != null) {
      _shortestSolution.add(parentNode._board);
      parentNode = parentNode._prevSearchNode;
    }
  }

  // есть ли решение головоломки
  bool isSolvable() {
    return _isSolvable;
  }

  // минимальное количество шагов решения; -1 если решения нет
  int moves() {
    if (!_isSolvable) return -1;
    return _shortestSolution.length - 1;
  }

  // список досок в кратчайшем решении; null если решения нет
  List<Board>? solution() {
    if (!_isSolvable) return null;
    List<Board> reverseSolution = [];
    for (int i = _shortestSolution.length - 1; i > -1; i--) {
      reverseSolution.add(_shortestSolution[i]);
    }
    return reverseSolution;
  }
}

// узел поиска решения
class _SearchNode {
  final Board _board;
  final int _moves; // количество уже совершенных ходов
  final _SearchNode?
      _prevSearchNode; // предыдущая доска (нужна для оптимизации поиска решения)
  late final int _manhattan;

  _SearchNode(Board board, int moves, _SearchNode? prevSearchNode)
      : _board = board,
        _moves = moves,
        _prevSearchNode = prevSearchNode {
    _manhattan = _board.manhattan();
  }

  // компаратор для приоритетной очереди
  static int nodeComparator(_SearchNode sn1, _SearchNode sn2) {
    return (sn1._moves + sn1._manhattan).compareTo(sn2._moves + sn2._manhattan);
  }
}
