import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../utils/game_utils.dart';

class GameInfoPanel extends StatelessWidget {
  final int moves;
  final Duration timeElapsed;
  final GameDifficulty difficulty;
  final VoidCallback onRestart;
  final VoidCallback onHome;

  const GameInfoPanel({
    Key? key,
    required this.moves,
    required this.timeElapsed,
    required this.difficulty,
    required this.onRestart,
    required this.onHome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Time section
          Expanded(
            child: _buildInfoItem(
              context,
              Icons.timer,
              'Time',
              GameUtils.formatDuration(timeElapsed),
            ),
          ),
          
          // Divider
          Container(
            height: 40,
            width: 1,
            color: Colors.white.withOpacity(0.2),
          ),
          
          // Moves section
          Expanded(
            child: _buildInfoItem(
              context,
              Icons.touch_app,
              'Moves',
              moves.toString(),
            ),
          ),
          
          // Divider
          Container(
            height: 40,
            width: 1,
            color: Colors.white.withOpacity(0.2),
          ),
          
          // Difficulty section
          Expanded(
            child: _buildInfoItem(
              context,
              Icons.grid_4x4,
              'Difficulty',
              _getDifficultyText(),
            ),
          ),
          
          // Control buttons
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.restart_alt),
                color: AppTheme.accentColor,
                tooltip: 'Restart Game',
                onPressed: onRestart,
              ),
              IconButton(
                icon: const Icon(Icons.home),
                color: AppTheme.secondaryColor,
                tooltip: 'Home',
                onPressed: onHome,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, IconData icon, String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: AppTheme.accentColor,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  String _getDifficultyText() {
    switch (difficulty) {
      case GameDifficulty.easy:
        return '4×4';
      case GameDifficulty.medium:
        return '6×6';
      case GameDifficulty.hard:
        return '8×8';
    }
  }
}