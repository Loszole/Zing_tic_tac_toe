import 'package:flutter/material.dart';
import '../game_logic.dart';

Future<void> showStartDialog({
  required BuildContext context,
  required void Function(GameMode mode, [AIDifficulty? aiDifficulty]) onSelected,
}) async {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Choose Mode'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('1 Player'),
              onTap: () {
                Navigator.pop(context);
                showAIDifficultyDialog(context: context, onSelected: onSelected);
              },
            ),
            ListTile(
              title: const Text('2 Player'),
              onTap: () {
                Navigator.pop(context);
                onSelected(GameMode.twoPlayer);
              },
            ),
          ],
        ),
      );
    },
  );
}

Future<void> showAIDifficultyDialog({
  required BuildContext context,
  required void Function(GameMode mode, [AIDifficulty? aiDifficulty]) onSelected,
}) async {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Select AI Difficulty'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Easy'),
              onTap: () {
                Navigator.pop(context);
                onSelected(GameMode.single, AIDifficulty.easy);
              },
            ),
            ListTile(
              title: const Text('Medium'),
              onTap: () {
                Navigator.pop(context);
                onSelected(GameMode.single, AIDifficulty.medium);
              },
            ),
            ListTile(
              title: const Text('Hard'),
              onTap: () {
                Navigator.pop(context);
                onSelected(GameMode.single, AIDifficulty.hard);
              },
            ),
            ListTile(
              title: const Text('Random'),
              onTap: () {
                Navigator.pop(context);
                onSelected(GameMode.single, AIDifficulty.random);
              },
            ),
          ],
        ),
      );
    },
  );
}
