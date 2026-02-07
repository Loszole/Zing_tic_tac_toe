import 'dart:math';

enum Player { X, O, none }

enum GameMode { single, twoPlayer }

enum AIDifficulty { easy, medium, hard, random }

class GameStats {
  int wins;
  int losses;
  int draws;

  GameStats({this.wins = 0, this.losses = 0, this.draws = 0});
}

class GameLogic {
  final int size;
  List<List<Player>> board;
  Player currentPlayer;
  GameMode mode;
  AIDifficulty aiDifficulty;
  Player winner = Player.none;
  bool isDraw = false;
  int moves = 0;

  GameLogic({
    required this.size,
    this.mode = GameMode.twoPlayer,
    this.aiDifficulty = AIDifficulty.easy,
  })  : board = List.generate(size, (_) => List.filled(size, Player.none)),
        currentPlayer = Player.X;

  void reset() {
    board = List.generate(size, (_) => List.filled(size, Player.none));
    currentPlayer = Player.X;
    winner = Player.none;
    isDraw = false;
    moves = 0;
  }

  bool makeMove(int row, int col) {
    if (board[row][col] != Player.none || winner != Player.none) return false;
    board[row][col] = currentPlayer;
    moves++;
    _checkWinner(row, col);
    if (winner == Player.none && moves == size * size) {
      isDraw = true;
    }
    if (mode == GameMode.single && winner == Player.none && !isDraw) {
      _aiMove();
    } else {
      currentPlayer = currentPlayer == Player.X ? Player.O : Player.X;
    }
    return true;
  }

  void _aiMove() {
    switch (aiDifficulty) {
      case AIDifficulty.easy:
        _randomMove();
        break;
      case AIDifficulty.medium:
        _mediumMove();
        break;
      case AIDifficulty.hard:
        _hardMove();
        break;
      case AIDifficulty.random:
        _randomMove();
        break;
    }
  }

  void _randomMove() {
    final empty = <List<int>>[];
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        if (board[i][j] == Player.none) empty.add([i, j]);
      }
    }
    if (empty.isNotEmpty) {
      final move = empty[Random().nextInt(empty.length)];
      board[move[0]][move[1]] = Player.O;
      moves++;
      _checkWinner(move[0], move[1]);
      if (winner == Player.none && moves == size * size) {
        isDraw = true;
      }
      currentPlayer = Player.X;
    }
  }

  void _mediumMove() {
    // Block or win if possible, else random
    if (!_tryWinOrBlock(Player.O)) {
      if (!_tryWinOrBlock(Player.X)) {
        _randomMove();
      }
    }
  }

  void _hardMove() {
    // Minimax or best move (for 3x3 only, else fallback to medium)
    if (size == 3) {
      final move = _findBestMove();
      if (move != null) {
        board[move[0]][move[1]] = Player.O;
        moves++;
        _checkWinner(move[0], move[1]);
        if (winner == Player.none && moves == size * size) {
          isDraw = true;
        }
        currentPlayer = Player.X;
        return;
      }
    }
    _mediumMove();
  }

  bool _tryWinOrBlock(Player p) {
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        if (board[i][j] == Player.none) {
          board[i][j] = p;
          if (_isWinner(p, i, j)) {
            if (p == Player.O) {
              moves++;
              _checkWinner(i, j);
              if (winner == Player.none && moves == size * size) {
                isDraw = true;
              }
              currentPlayer = Player.X;
            } else {
              board[i][j] = Player.O;
              moves++;
              _checkWinner(i, j);
              if (winner == Player.none && moves == size * size) {
                isDraw = true;
              }
              currentPlayer = Player.X;
            }
            return true;
          }
          board[i][j] = Player.none;
        }
      }
    }
    return false;
  }

  List<int>? _findBestMove() {
    int bestScore = -1000;
    List<int>? bestMove;
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        if (board[i][j] == Player.none) {
          board[i][j] = Player.O;
          int score = _minimax(0, false);
          board[i][j] = Player.none;
          if (score > bestScore) {
            bestScore = score;
            bestMove = [i, j];
          }
        }
      }
    }
    return bestMove;
  }

  int _minimax(int depth, bool isMax) {
    if (_isWinner(Player.O)) return 10 - depth;
    if (_isWinner(Player.X)) return depth - 10;
    if (_isDraw()) return 0;
    int best = isMax ? -1000 : 1000;
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        if (board[i][j] == Player.none) {
          board[i][j] = isMax ? Player.O : Player.X;
          int score = _minimax(depth + 1, !isMax);
          board[i][j] = Player.none;
          if (isMax) {
            best = max(best, score);
          } else {
            best = min(best, score);
          }
        }
      }
    }
    return best;
  }

  void _checkWinner(int row, int col) {
    if (_isWinner(currentPlayer, row, col)) {
      winner = currentPlayer;
    }
  }

  bool _isWinner(Player p, [int? row, int? col]) {
    // Check row
    if (row != null && board[row].every((cell) => cell == p)) return true;
    // Check col
    if (col != null && List.generate(size, (i) => board[i][col]).every((cell) => cell == p)) return true;
    // Check main diag
    if (row == col && List.generate(size, (i) => board[i][i]).every((cell) => cell == p)) return true;
    // Check anti diag
    if (row != null && col != null && row + col == size - 1 && List.generate(size, (i) => board[i][size - 1 - i]).every((cell) => cell == p)) return true;
    return false;
  }

  bool _isDraw() {
    for (var row in board) {
      for (var cell in row) {
        if (cell == Player.none) return false;
      }
    }
    return true;
  }
}
