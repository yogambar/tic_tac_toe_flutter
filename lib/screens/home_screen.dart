import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../widgets/board_tile.dart';
import '../widgets/player_indicator.dart';
import '../utils/game_logic.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Simulate loading state
  bool _isLoading = true;
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  String? winner;
  bool isDraw = false;

  @override
  void initState() {
    super.initState();
    // Simulate some loading time
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void handleTap(int index) {
    if (_isLoading || board[index] != '' || winner != null) return;

    setState(() {
      board[index] = currentPlayer;
      winner = checkWinner(board);
      isDraw = !board.contains('') && winner == null;
      if (winner == null && !isDraw) {
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      }
    });
  }

  void restartGame() {
    setState(() {
      board = List.filled(9, '');
      currentPlayer = 'X';
      winner = null;
      isDraw = false;
    });
  }

  Widget _buildAnimatedSkimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: AspectRatio(
        aspectRatio: 1,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(), // Disable scrolling of the skimmer
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10, // Increased main axis spacing
            crossAxisSpacing: 10, // Increased cross axis spacing
          ),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tic Tac Toe')),
      body: SingleChildScrollView( // Added SingleChildScrollView to fix bottom overflow
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PlayerIndicator(
              currentPlayer: currentPlayer,
              winner: winner,
              isDraw: isDraw,
            ),
            const SizedBox(height: 20),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _isLoading ? _buildAnimatedSkimmer() : AspectRatio(
                aspectRatio: 1,
                child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10, // Increased main axis spacing
                    crossAxisSpacing: 10, // Increased cross axis spacing
                  ),
                  itemBuilder: (context, index) {
                    return BoardTile(
                      value: board[index],
                      onTap: () => handleTap(index),
                      highlight: winner != null &&
                          getWinningCombination(board).contains(index),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : restartGame, // Disable button while loading
              icon: const Icon(Icons.restart_alt),
              label: const Text('Restart Game'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
