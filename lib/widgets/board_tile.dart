import 'package:flutter/material.dart';

class BoardTile extends StatelessWidget {
  final String value;
  final VoidCallback onTap;
  final bool highlight;

  const BoardTile({
    super.key,
    required this.value,
    required this.onTap,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: highlight ? Colors.green.withOpacity(0.3) : Colors.grey.shade900,
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) =>
                ScaleTransition(scale: animation, child: child),
            child: Text(
              value,
              key: ValueKey(value),
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: value == 'X' ? Colors.blueAccent : Colors.redAccent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

