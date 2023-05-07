import 'package:flutter/material.dart';

import '../board/board_image.dart';
import '../solution_algorithm/board.dart';
import '../solution_algorithm/solver.dart';

typedef BoardListView = List<List<int>>;

// страница отображается, если решения головоломки есть
// на странице представлены шаги решения
class SolutionPage extends StatelessWidget {
  final Solver solver;

  const SolutionPage(this.solver, {super.key});

  List<BoardImage> createSolutionList() {
    int move = 0;
    List<BoardImage> createSolutionList = [];
    for (Board b in solver.getSolution()) {
      createSolutionList.add(BoardImage(b.getBoard(), move));
      move++;
    }

    return createSolutionList;
  }

  // определение правильной формы для слова 'ход'
  String endingsForm(int n) {
    n = n.abs() % 100;
    int n1 = n % 10;
    if (n > 10 && n < 20) return 'ходов';
    if (n1 > 1 && n1 < 5) return 'хода';
    if (n1 == 1) return 'ход';
    return 'ходов';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('Все решается в ${solver.getMoves()} ${endingsForm(solver.getMoves())}')),
      body: SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: createSolutionList()),
            // children: ,
      ),
    );
  }
}
