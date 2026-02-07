import 'package:flutter/material.dart';
import '../game_logic.dart';

class GameBoard extends StatelessWidget {
  final GameLogic game;
  final void Function(int, int) onMove;
  final bool highlightWin;

  const GameBoard({
    Key? key,
    required this.game,
    required this.onMove,
    this.highlightWin = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GridView.builder(
        itemCount: game.size * game.size,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: game.size,
        ),
        itemBuilder: (context, index) {
          final row = index ~/ game.size;
          final col = index % game.size;
          final cell = game.board[row][col];
          return GestureDetector(
            onTap: () => onMove(row, col),
            child: Card(
              color: Theme.of(context).colorScheme.surface,
              child: Center(
                child: Text(
                  cell == Player.X ? 'X' : cell == Player.O ? 'O' : '',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 32),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
