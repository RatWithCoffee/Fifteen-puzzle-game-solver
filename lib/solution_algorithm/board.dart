// класс для представления игровой доски головоломки
class Board {
  // представление игровой доски в виде массива n*n строк с плиткам
  late final List<List<int>> _board;

  late final int _manhattan;

  // манхэттенское расстояние между данной доской и целевой доской
  // вычисляется как сумма расстояний от каждой плитки до ее целевой позиции

  // в конструктор передается уже валидный массив
  Board(List<List<int>> tiles) {
    _board = List.from(tiles);
    _manhattan = _countManhattan();
  }

  // для подсчета манхэттенского расстояния
  int _countManhattan() {
    int manhattan = 0;
    int goalRow, goalCol;
    for (int i = 0; i < _board.length; i++) {
      for (int j = 0; j < _board.length; j++) {
        if (_board[i][j] == 0) {
          continue;
        }
        goalCol = (_board[i][j] - 1) % _board.length;
        goalRow = (_board[i][j] - 1) ~/ _board.length;
        manhattan += (j - goalCol).abs() + (i - goalRow).abs();
      }
    }
    return manhattan;
  }

  // строковое представление доски
  @override
  String toString() {
    StringBuffer strBoard = StringBuffer();
    strBoard.write(_board.length);
    strBoard.write('\n');
    for (List<int> row in _board) {
      strBoard.writeAll(row, ' ');
      strBoard.write('\n');
    }
    return strBoard.toString();
  }

  // размерность игровой доски
  int dimension() {
    return _board.length;
  }

  int manhattan() {
    return _manhattan;
  }

  // текущая доска является целевой?
  bool isGoal() {
    return _manhattan == 0;
  }

  List<List<int>> getBoard() {
    return List.from(_board);
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
    if (other._board.length != _board.length) {
      return false;
    }
    // проверка соответствующих плиток
    for (int i = 0; i < _board.length; i++) {
      for (int j = 0; j < _board[i].length; j++) {
        if (_board[i][j] != other._board[i][j]) return false;
      }
    }

    return true;
  }

  @override
  int get hashCode => Object.hash(_board, _manhattan);

  // возвращает список результатов всех возможных ходов из текущего состояния
  List<Board> neighbors() {
    List<Board> neighbors = [];

    // находим пустую клетку
    int emptyTileRow = 0, emptyTileCol = 0;
    cycle:
    for (int i = 0; i < _board.length; i++) {
      for (int j = 0; j < _board.length; j++) {
        if (_board[i][j] == 0) {
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
    return i >= 0 && i < _board.length;
  }

  // возвращает доску, полученную перестановкой пустой и соседней непустой плитки
  Board _createNeighbourBoard(int row1, int col1, int row2, int col2) {
    List<List<int>> neighbourBoard =
        List.generate(_board.length, (i) => List.from(_board[i]));

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
    if (_board[0][0] != 0 && _board[0][1] != 0) {
      row = 0;
    } else {
      row = 1;
    }

    return _createNeighbourBoard(row, 0, row, 1);
  }
}
