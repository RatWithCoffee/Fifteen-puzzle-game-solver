// класс для представления игровой доски головоломки
class Board {
  // представление игровой доски в виде массива n*n строк с плиткам
  final List<List<int>> board;

  int manhattan = -1;

  // манхэттенское расстояние между данной доской и целевой доской
  // вычисляется как сумма расстояний от каждой плитки до ее целевой позиции

  // в конструктор передается уже валидный массив
  Board(List<List<int>> tiles) : board = List.from(tiles);

  // для подсчета манхэттенского расстояния
  int _countManhattan() {
    int manhattan = 0;
    int goalRow, goalCol;
    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < board.length; j++) {
        if (board[i][j] == 0) {
          continue;
        }
        goalCol = (board[i][j] - 1) % board.length;
        goalRow = (board[i][j] - 1) ~/ board.length;
        manhattan += (j - goalCol).abs() + (i - goalRow).abs();
      }
    }
    return manhattan;
  }

  // строковое представление доски
  @override
  String toString() {
    StringBuffer strBoard = StringBuffer();
    strBoard.write(board.length);
    strBoard.write('\n');
    for (List<int> row in board) {
      strBoard.writeAll(row, ' ');
      strBoard.write('\n');
    }
    return strBoard.toString();
  }

  // размерность игровой доски
  int getDimension() {
    return board.length;
  }

  int getManhattan() {
    // если манхэттенское расстояние еще не было подсчитано
    if (manhattan == -1) manhattan = _countManhattan();
    return manhattan;
  }

  // текущая доска является целевой?
  bool isGoal() {
    return manhattan == 0;
  }

  List<List<int>> getBoard() {
    return List.from(board);
  }

  // две игровые доски равны, если их размерности равны
  // и если соответствующие плитки в одинаковых позициях
  @override
  bool operator ==(Object other) {
    return other is Board &&
        other.runtimeType == runtimeType &&
        _checkValues(other) == _checkValues(this);
  }

  // проверка полей обьектов на равенство
  bool _checkValues(Board other) {
    // проверка равенства размерности игровых досок
    if (other.board.length != board.length) {
      return false;
    }
    // проверка соответствующих плиток
    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < board[i].length; j++) {
        if (board[i][j] != other.board[i][j]) return false;
      }
    }

    return true;
  }

  @override
  int get hashCode => Object.hash(board, manhattan);

  // возвращает список результатов всех возможных ходов из текущего состояния
  List<Board> getNeighbors() {
    List<Board> neighbors = [];

    // находим пустую клетку
    int emptyTileRow = 0, emptyTileCol = 0;
    cycle:
    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < board.length; j++) {
        if (board[i][j] == 0) {
          emptyTileRow = i;
          emptyTileCol = j;
          break cycle;
        }
      }
    }

    // список строк и столбцов плиток для перестановки
    List<int> indices = [
      emptyTileRow,
      emptyTileCol - 1,
      emptyTileRow - 1,
      emptyTileCol,
      emptyTileRow,
      emptyTileCol + 1,
      emptyTileRow + 1,
      emptyTileCol
    ];

    for (int i = 0; i < indices.length; i += 2) {
      // если номер строки и номер столбца плитки валидные ->
      // добавляем новую доску в возвращаемый список
      if (_isIndexValid(indices[i]) && _isIndexValid(indices[i + 1])) {
        neighbors.add(_createNeighbourBoard(
            indices[i], indices[i + 1], emptyTileRow, emptyTileCol));
      }
    }

    return neighbors;
  }

  bool _isIndexValid(int i) {
    return i >= 0 && i < board.length;
  }

  // возвращает доску, полученную перестановкой пустой и соседней непустой плитки
  Board _createNeighbourBoard(int row1, int col1, int row2, int col2) {
    List<List<int>> neighbourBoard =
        List.generate(board.length, (i) => List.from(board[i]));

    // меняем плитки
    int temp = neighbourBoard[row1][col1];
    neighbourBoard[row1][col1] = neighbourBoard[row2][col2];
    neighbourBoard[row2][col2] = temp;
    return Board(neighbourBoard);
  }

  // возвращает доску, полученную перестановкой пары непустых плиток
  // это потом используется для проверки наличия у головоломки решения в классе Solver
  Board twin() {
    int row;
    if (board[0][0] != 0 && board[0][1] != 0) {
      row = 0;
    } else {
      row = 1;
    }

    return _createNeighbourBoard(row, 0, row, 1);
  }
}
