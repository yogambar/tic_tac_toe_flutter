/// Tic-Tac-Toe Game Logic Utilities

/// List of all winning combinations (rows, columns, diagonals)
List<List<int>> winningCombinations = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6],
];

/// Check for a winner and return 'X' or 'O' if found, else null
String? checkWinner(List<String> board) {
  for (var combo in winningCombinations) {
    final a = board[combo[0]];
    final b = board[combo[1]];
    final c = board[combo[2]];
    if (a.isNotEmpty && a == b && b == c) {
      return a;
    }
  }
  return null;
}

/// Return the winning combination indices, if any
List<int> getWinningCombination(List<String> board) {
  for (var combo in winningCombinations) {
    final a = board[combo[0]];
    final b = board[combo[1]];
    final c = board[combo[2]];
    if (a.isNotEmpty && a == b && b == c) {
      return combo;
    }
  }
  return [];
}

