import 'package:flutter/material.dart';
import 'package:puzzle/pages/no_solution_page.dart';
import 'package:puzzle/pages/solution_page.dart';
import 'package:puzzle/solution_algorithm/board.dart';
import 'package:puzzle/solution_algorithm/solver.dart';

// определяет решение головоломки и
// отображает одну из двух возможных страниц  в зависимости от наличия решения
class FindSolution {
  static Widget getSolutionPage(List<List<int>> initialBoard) {
    Solver solver = Solver(Board(initialBoard));

    if (!solver.isSolvable()) {
      // нет решения
      return const NoSolutionPage();
    }

    return SolutionPage(solver);
  }
}
