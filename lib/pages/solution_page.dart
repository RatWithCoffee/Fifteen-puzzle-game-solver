import 'package:flutter/material.dart';

import '../board/board_image.dart';

typedef BoardListView = List<List<int>>;

// страница отображается, если решения головоломки есть
// на странице представлены шаги решения
class SolutionPage extends StatelessWidget {
  final List<BoardListView> _boards;

  const SolutionPage(this._boards, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Шаги решения')),
      body: SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _boards.map((board) => BoardImage(board)).toList()),
      ),
    );
  }
}
