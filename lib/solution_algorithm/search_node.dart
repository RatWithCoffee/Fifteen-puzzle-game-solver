// узел поиска решения
import 'board.dart';

class SearchNode {
  final Board board;
  final int moves; // количество уже совершенных ходов
  final SearchNode?
      prevSearchNode; // предыдущая доска (нужна для оптимизации поиска решения)
  final int manhattan;

  SearchNode(this.board, this.moves, this.prevSearchNode)
      : manhattan = board.getManhattan();

  // компаратор для приоритетной очереди
  static int nodeComparator(SearchNode sn1, SearchNode sn2) {
    return (sn1.getMoves() + sn1.getManhattan())
        .compareTo(sn2.getMoves() + sn2.getManhattan());
  }

  int getManhattan() {
    return manhattan;
  }

  Board getBoard() {
    return board;
  }

  SearchNode? getPrevSearchNode() {
    return prevSearchNode;
  }

  int getMoves() {
    return moves;
  }
}
