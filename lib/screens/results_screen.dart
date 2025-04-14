import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../config/theme.dart';
import '../utils/game_utils.dart';
import 'home_screen.dart';
import 'game_screen.dart';

class ResultsScreen extends StatelessWidget {
  final Duration timeElapsed;
  final int moves;
  final GameDifficulty difficulty;

  const ResultsScreen({
    Key? key,
    required this.timeElapsed,
    required this.moves,
    required this.difficulty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppTheme.backgroundColor,
                AppTheme.accentColor.withOpacity(0.2),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              _buildCongratulations()
                  .animate()
                  .fadeIn(duration: 800.ms)
                  .scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1, 1),
                    duration: 800.ms,
                    curve: Curves.easeOutBack,
                  ),
              const SizedBox(height: 40),
              _buildStats()
                  .animate()
                  .fadeIn(delay: 400.ms, duration: 800.ms)
                  .slideY(
                    begin: 0.2,
                    end: 0,
                    delay: 400.ms,
                    duration: 800.ms,
                    curve: Curves.easeOutCubic,
                  ),
              const SizedBox(height: 40),
              _buildButtons(context)
                  .animate()
                  .fadeIn(delay: 800.ms, duration: 800.ms)
                  .slideY(
                    begin: 0.2,
                    end: 0,
                    delay: 800.ms,
                    duration: 800.ms,
                    curve: Curves.easeOutCubic,
                  ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCongratulations() {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: AppTheme.accentColor.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.emoji_events,
            color: AppTheme.accentColor,
            size: 80,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Congratulations!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'You\'ve completed the ${_getDifficultyText()} memory challenge',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildStats() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Your Results',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildStatItem(
                'Time',
                GameUtils.formatDuration(timeElapsed),
                Icons.timer,
                AppTheme.primaryColor,
              ),
              Container(
                height: 50,
                width: 1,
                color: Colors.white.withOpacity(0.1),
              ),
              _buildStatItem(
                'Moves',
                moves.toString(),
                Icons.touch_app,
                AppTheme.secondaryColor,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildRating(),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRating() {
    final rating = _calculateRating();
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Rating: ',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 16,
            ),
          ),
          for (int i = 0; i < 5; i++)
            Icon(
              i < rating ? Icons.star : Icons.star_border,
              color: i < rating ? Colors.amber : Colors.white30,
              size: 24,
            ),
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const HomeScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var begin = const Offset(-1.0, 0.0);
                    var end = Offset.zero;
                    var curve = Curves.easeInOut;
                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                ),
              );
            },
            icon: const Icon(Icons.home),
            label: const Text('Home'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.1),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      GameScreen(difficulty: difficulty),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var begin = const Offset(1.0, 0.0);
                    var end = Offset.zero;
                    var curve = Curves.easeInOut;
                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                ),
              );
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Play Again'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  String _getDifficultyText() {
    switch (difficulty) {
      case GameDifficulty.easy:
        return 'Easy';
      case GameDifficulty.medium:
        return 'Medium';
      case GameDifficulty.hard:
        return 'Hard';
    }
  }

  int _calculateRating() {
    // Calculate a rating based on time and moves
    int rating = 5; // Start with perfect score
    
    // Get expected values for the difficulty level
    int expectedMoves;
    int expectedTimeSeconds;
    
    switch (difficulty) {
      case GameDifficulty.easy:
        expectedMoves = 20;
        expectedTimeSeconds = 60;
        break;
      case GameDifficulty.medium:
        expectedMoves = 50;
        expectedTimeSeconds = 180;
        break;
      case GameDifficulty.hard:
        expectedMoves = 100;
        expectedTimeSeconds = 360;
        break;
    }
    
    // Reduce rating based on moves
    if (moves > expectedMoves * 2) {
      rating -= 2;
    } else if (moves > expectedMoves * 1.5) {
      rating -= 1;
    }
    
    // Reduce rating based on time
    if (timeElapsed.inSeconds > expectedTimeSeconds * 2) {
      rating -= 2;
    } else if (timeElapsed.inSeconds > expectedTimeSeconds * 1.5) {
      rating -= 1;
    }
    
    // Ensure rating is between 1 and 5
    return rating.clamp(1, 5);
  }
}