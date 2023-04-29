import 'package:flutter/material.dart';
import 'package:puzzle/pages/no_solution_page.dart';
import 'package:puzzle/pages/solution_page.dart';
import 'package:puzzle/solution_algorithm/board.dart';
import 'package:puzzle/solution_algorithm/solver.dart';


// определяет решение головоломки и
// отображает одну из двух возможных страниц  в зависимости от наличия решения
class FindSolution extends StatelessWidget {
  late final List<BoardListView> boards; // массив ходов решения

  FindSolution(List<List<int>> initialBoard, {super.key}) {
    Solver solver = Solver(Board(initialBoard));

    boards = [];
    if (solver.solution() != null) { // если решение есть
      for (Board b in solver.solution()!) {
        boards.add(b.getBoard());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (boards.isEmpty) {
      // нет решения
      return NoSolutionPage();
    }

    return SolutionPage(boards);
  }
}
