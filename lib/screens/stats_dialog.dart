import 'package:flutter/material.dart';
import 'dart:convert';

class StatsDialog extends StatelessWidget {
  final Map<String, dynamic> stats;
  final VoidCallback onReset;
  final List<Map<String, dynamic>>? history;

  const StatsDialog({
    super.key,
    required this.stats,
    required this.onReset,
    this.history,
  });

  Color _resultColor(String winner, String mode) {
    if (winner == 'Draw') return Colors.grey;
    if (mode == 'Single') {
      return winner == 'X' ? Colors.green : Colors.red;
    } else {
      return winner == 'X' ? Colors.blue : winner == 'O' ? Colors.red : Colors.grey;
    }
  }

  String _resultText(String winner, String mode) {
    if (winner == 'Draw') return 'DRAW';
    if (mode == 'Single') return winner == 'X' ? 'WON' : 'LOST';
    return winner == 'X' ? 'X WON' : winner == 'O' ? 'O WON' : 'DRAW';
  }

  void _showPreview(BuildContext context, Map<String, dynamic> game) {
    final board = (game['board'] is String)
        ? List<List<String>>.from(
            (jsonDecode(game['board']) as List)
                .map((row) => List<String>.from(row)))
        : <List<String>>[];
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Game Preview'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${game['date']?.toString().substring(0, 19).replaceFirst('T', ' ')}'),
            Text('${game['size']}x${game['size']} | ${game['mode']}'),
            Text('Result: ${_resultText(game['winner'], game['mode'])}',
                style: TextStyle(
                  color: _resultColor(game['winner'], game['mode']),
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 8),
            if (board.isNotEmpty)
              Table(
                defaultColumnWidth: const FixedColumnWidth(28),
                children: board
                    .map((row) => TableRow(
                          children: row
                              .map((cell) => Center(
                                    child: Text(
                                      cell == 'none' ? '' : cell.toUpperCase(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: cell == 'X'
                                            ? Colors.blue[300]
                                            : cell == 'O'
                                                ? Colors.red[300]
                                                : Colors.grey,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ))
                    .toList(),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Game History'),
      content: SizedBox(
        width: 340,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (history != null && history!.isNotEmpty) ...[
                ...history!.reversed.take(20).map((game) {
                  final date = game['date']?.toString().substring(0, 10);
                  final result = _resultText(game['winner'], game['mode']);
                  final color = _resultColor(game['winner'], game['mode']);
                  return InkWell(
                    onTap: () => _showPreview(context, game),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(date ?? '', style: const TextStyle(fontSize: 15)),
                                Text('${game['mode']} | ${game['size']}x${game['size']}', style: const TextStyle(fontSize: 13, color: Colors.grey)),
                              ],
                            ),
                          ),
                          Text(result, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
                        ],
                      ),
                    ),
                  );
                }),
              ] else
                const Text('No game history yet.'),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            onReset();
            Navigator.pop(context);
          },
          child: const Text('Reset'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
