import 'package:flutter/material.dart';

class PlayerIndicator extends StatelessWidget {
  final String currentPlayer;
  final String? winner;
  final bool isDraw;

  const PlayerIndicator({
    super.key,
    required this.currentPlayer,
    this.winner,
    this.isDraw = false,
  });

  @override
  Widget build(BuildContext context) {
    String displayText;

    if (winner != null) {
      displayText = '$winner wins!';
    } else if (isDraw) {
      displayText = 'It\'s a draw!';
    } else {
      displayText = 'Current Player: $currentPlayer';
    }

    return Text(
      displayText,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}

