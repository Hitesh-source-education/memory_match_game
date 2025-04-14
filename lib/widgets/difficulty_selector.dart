import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../utils/game_utils.dart';

class DifficultySelector extends StatelessWidget {
  final Function(GameDifficulty) onDifficultySelected;

  const DifficultySelector({
    Key? key,
    required this.onDifficultySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Select Difficulty',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 24),
        _buildDifficultyOption(
          context,
          GameDifficulty.easy,
          'Easy',
          '4×4 Grid • 8 Pairs',
          Colors.green,
          Icons.sentiment_very_satisfied,
        ),
        const SizedBox(height: 16),
        _buildDifficultyOption(
          context,
          GameDifficulty.medium,
          'Medium',
          '6×6 Grid • 18 Pairs',
          Colors.orange,
          Icons.sentiment_satisfied,
        ),
        const SizedBox(height: 16),
        _buildDifficultyOption(
          context,
          GameDifficulty.hard,
          'Hard',
          '8×8 Grid • 32 Pairs',
          Colors.red,
          Icons.sentiment_very_dissatisfied,
        ),
      ],
    );
  }

  Widget _buildDifficultyOption(
    BuildContext context,
    GameDifficulty difficulty,
    String title,
    String subtitle,
    Color color,
    IconData icon,
  ) {
    return GestureDetector(
      onTap: () => onDifficultySelected(difficulty),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: color.withOpacity(0.5),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 32,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: color.withOpacity(0.7),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}