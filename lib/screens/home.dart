import 'package:flutter/material.dart';

import '../game_logic.dart';
import '../storage.dart';
import 'dart:convert';
import 'game_board.dart';
import 'stats_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  int _boardSize = 3;
  GameMode _mode = GameMode.single;
  AIDifficulty _aiDifficulty = AIDifficulty.easy;
  late GameLogic _game;
  Map<String, dynamic> _stats = {};
  List<Map<String, dynamic>> _history = [];
  bool _gameStarted = false;

  @override
  void initState() {
    super.initState();
    _game = GameLogic(
      size: _boardSize,
      mode: _mode,
      aiDifficulty: _aiDifficulty,
    );
    _loadStats();
  }

  Future<void> _loadStats() async {
    final stats = await StatsStorage.loadStats();
    setState(() {
      _stats = stats;
      _history = (stats['history'] as List?)?.cast<Map<String, dynamic>>() ?? [];
    });
  }

  Future<void> _resetStats() async {
    await StatsStorage.resetStats();
    _loadStats();
  }

  Future<void> _recordGame() async {
    final record = {
      'date': DateTime.now().toIso8601String(),
      'size': _game.size,
      'mode': _mode == GameMode.single ? 'Single' : 'Two Player',
      'winner': _game.isDraw
          ? 'Draw'
          : _game.winner == Player.X
              ? 'X'
              : _game.winner == Player.O
                  ? 'O'
                  : '',
      'board': jsonEncode(_game.board.map((row) => row.map((cell) => cell.toString().split('.').last).toList()).toList()),
    };
    final stats = await StatsStorage.loadStats();
    final history = (stats['history'] as List?) ?? [];
    history.add(record);
    stats['history'] = history;
    await StatsStorage.saveStats(stats);
    _loadStats();
  }

  void _startNewGame() {
    setState(() {
      _gameStarted = true;
      _game = GameLogic(
        size: _boardSize,
        mode: _mode,
        aiDifficulty: _aiDifficulty,
      );
    });
  }

  // ---------------- DIALOGS ----------------

  void _showModeDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Choose Mode'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('1 Player'),
              onTap: () {
                Navigator.pop(context);
                _showAIDifficultyDialog();
              },
            ),
            ListTile(
              title: const Text('2 Player'),
              onTap: () {
                _mode = GameMode.twoPlayer;
                Navigator.pop(context);
                _startNewGame();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAIDifficultyDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Select AI Difficulty'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: AIDifficulty.values.map((difficulty) {
            return ListTile(
              title: Text(difficulty.name.toUpperCase()),
              onTap: () {
                _mode = GameMode.single;
                _aiDifficulty = difficulty;
                Navigator.pop(context);
                _startNewGame();
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  // ---------------- UI ----------------

  void _handleMove(int row, int col) {
    setState(() => _game.makeMove(row, col));
    if (_game.winner != Player.none || _game.isDraw) {
      _recordGame();
    }
  }

  Widget _buildBoard() {
    return GameBoard(
      game: _game,
      onMove: (row, col) {
        if (_game.winner == Player.none && !_game.isDraw) {
          _handleMove(row, col);
        }
      },
      highlightWin: true,
    );
  }

  String _getStatusText() {
    if (_game.isDraw) return 'DRAW!';
    if (_game.winner == Player.X) return 'You Won!';
    if (_game.winner == Player.O) return _mode == GameMode.single ? 'You Lost!' : 'Player O wins!';
    return _mode == GameMode.single ? 'Your Turn' : 'Player ${_game.currentPlayer == Player.X ? 'X' : 'O'}\'s Turn';
  }

  String _getStatusSubtext() {
    if (_game.isDraw) return 'It\'s a draw';
    if (_game.winner == Player.X) return 'Congratulations';
    if (_game.winner == Player.O) return 'Good luck next time';
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _gameStarted
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    _gameStarted = false;
                  });
                },
              )
            : null,
        title: const Text('Tic Tac Toe'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => StatsDialog(
                  stats: _stats,
                  onReset: _resetStats,
                  history: _history,
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: !_gameStarted
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Image.asset(
                      'lib/assets/logo.png',
                      width: 300,
                      height: 300,
                    ),
                  ),
                  DropdownButton<int>(
                    value: _boardSize,
                    items: const [3, 6, 9]
                        .map((size) => DropdownMenuItem(
                              value: size,
                              child: Text('${size}x$size'),
                            ))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) {
                        setState(() {
                          _boardSize = v;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _showModeDialog,
                    child: const Text('Start Game'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(180, 60),
                      textStyle: const TextStyle(fontSize: 24),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  const SizedBox(height: 8),
                  Text(
                    _getStatusText(),
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: _game.isDraw
                          ? Theme.of(context).colorScheme.onSurface
                          : _game.winner == Player.X
                              ? Colors.blue[300]
                              : _game.winner == Player.O
                                  ? Colors.red[300]
                                  : Theme.of(context).colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (_getStatusSubtext().isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 12.0),
                      child: Text(
                        _getStatusSubtext(),
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey[400]
                              : Colors.grey[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                    child: _buildBoard(),
                  ),
                  if (_game.winner != Player.none || _game.isDraw)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: SizedBox(
                        width: 220,
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.refresh),
                          label: const Text('Play Again'),
                          onPressed: () {
                            setState(() {
                              _gameStarted = false;
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            textStyle: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),
                ],
              ),
      ),
    );
  }
}
