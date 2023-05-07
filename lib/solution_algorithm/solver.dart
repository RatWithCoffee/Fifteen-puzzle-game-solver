import 'package:collection/collection.dart';
import 'package:puzzle/solution_algorithm/search_node.dart';

import 'board.dart';

// класс для решения пятнашек с использованием алгоритма А*
class Solver {
  final List<Board> shortestSolution = []; // список ходов в кратчайшем решении

  final Board initialBoard;

  bool hasSolution = true; // решаема ли головоломка

  Solver(this.initialBoard);

  // метод для нахождения решения
  // вызывается только один раз при первом вызове одного из геттеров
  void _findSolution() {
    int currMove = 0; // номер текущего шага
    int currMoveTwin = 0;

    // инициализация приоритетной очереди для переданных в конструктор пятнашек
    PriorityQueue<SearchNode> nodes = PriorityQueue(SearchNode.nodeComparator);
    nodes.add(SearchNode(initialBoard, currMove, null));
    // инициализация приоритетной очереди для вторых пятнашек,
    // полученных перестановкой двух непустых плиток в исходной головоломке
    PriorityQueue<SearchNode> nodesTwin =
        PriorityQueue(SearchNode.nodeComparator);
    nodesTwin.add(SearchNode(initialBoard.twin(), currMoveTwin, null));

    SearchNode? parentNode;
    SearchNode? grandparentNode;
    SearchNode? parentNodeTwin;
    SearchNode? grandparentNodeTwin;
    // ищем ход решения или выясняем, что решения нет
    while (!nodes.first.getBoard().isGoal()) {
      // удаляем из очереди доску с наибольшим приоритетом
      parentNode = nodes.removeFirst();
      currMove = parentNode.getMoves() + 1;
      grandparentNode = parentNode.getPrevSearchNode();

      parentNodeTwin = nodesTwin.removeFirst();
      currMoveTwin = parentNodeTwin.getMoves() + 1;
      grandparentNodeTwin = parentNodeTwin.getPrevSearchNode();

      // добавляем соседние доски в приоритетную очередь
      for (Board neighbor in parentNode.getBoard().getNeighbors()) {
        // не добавляем в очередь повторы
        if (grandparentNode == null || grandparentNode.getBoard() != neighbor) {
          nodes.add(SearchNode(neighbor, currMove, parentNode));
        }
      }

      for (Board neighbor in parentNodeTwin.getBoard().getNeighbors()) {
        // не добавляем в очередь повторы
        if (grandparentNodeTwin == null ||
            grandparentNodeTwin.getBoard() != neighbor) {
          nodesTwin.add(SearchNode(neighbor, currMoveTwin, parentNodeTwin));
        }
      }

      // если вторая доска нашла решение, то значит первая его не имеет
      if (nodesTwin.first.getBoard().isGoal()) {
        hasSolution = false;
        return;
      }
    }

    // решение есть -> создаем массив ходов в кратчайшем решении
    parentNode = nodes.first;
    while (parentNode != null) {
      shortestSolution.add(parentNode.getBoard());
      parentNode = parentNode.getPrevSearchNode();
    }
  }

  // есть ли решение головоломки
  bool isSolvable() {
    if (hasSolution && shortestSolution.isEmpty) {
      // findSolution еще не был вызван
      _findSolution();
    }

    return hasSolution;
  }

  // минимальное количество шагов решения; -1 если решения нет
  int getMoves() {
    if (hasSolution && shortestSolution.isEmpty) {
      // findSolution еще не был вызван
      _findSolution();
    }

    if (!hasSolution) return -1;
    return shortestSolution.length - 1;
  }

  // список досок в кратчайшем решении; возвращает пустой список, если решения нет
  List<Board> getSolution() {
    if (hasSolution && shortestSolution.isEmpty) {
      // findSolution еще не был вызван
      _findSolution();
    }

    if (!hasSolution) return [];
    List<Board> reverseSolution = [];
    for (int i = shortestSolution.length - 1; i > -1; i--) {
      reverseSolution.add(shortestSolution[i]);
    }
    return reverseSolution;
  }
}
