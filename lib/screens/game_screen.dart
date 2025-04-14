import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../config/theme.dart';
import '../models/card_model.dart';
import '../utils/game_utils.dart';
import '../widgets/memory_card.dart';
import '../widgets/game_info_panel.dart';
import 'home_screen.dart';
import 'results_screen.dart';

class GameScreen extends StatefulWidget {
  final GameDifficulty difficulty;

  const GameScreen({
    Key? key,
    required this.difficulty,
  }) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  late List<MemoryCard> _cards;
  List<MemoryCard> _flippedCards = [];
  bool _lockBoard = false;
  int _moves = 0;
  int _matchedPairs = 0;
  int _totalPairs = 0;
  Timer? _timer;
  Duration _timeElapsed = Duration.zero;
  bool _isGameStarted = false;
  bool _isGameFinished = false;
  
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    
    _animationController.forward();
    _initializeGame();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _initializeGame() {
    // Generate cards based on difficulty
    _cards = GameUtils.generateCards(widget.difficulty);
    _totalPairs = GameUtils.getPairCount(widget.difficulty);
    _matchedPairs = 0;
    _moves = 0;
    _timeElapsed = Duration.zero;
    _flippedCards = [];
    _isGameStarted = false;
    _isGameFinished = false;
    _lockBoard = false;
  }

  void _startTimer() {
    if (_isGameStarted) return;
    
    _isGameStarted = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timeElapsed += const Duration(seconds: 1);
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _onCardPressed(MemoryCard card) {
    // Start the timer on first card press
    if (!_isGameStarted) {
      _startTimer();
    }
    
    // Don't allow flipping more than 2 cards at once
    if (_lockBoard || _flippedCards.length >= 2) return;
    
    // Don't allow flipping already matched cards
    if (card.isMatched) return;
    
    // Don't allow flipping the same card twice
    if (_flippedCards.isNotEmpty && _flippedCards[0].id == card.id) return;
    
    setState(() {
      // Flip the card
      final index = _cards.indexWhere((c) => c.id == card.id);
      _cards[index] = _cards[index].copyWith(isFlipped: true);
      _flippedCards.add(_cards[index]);
      
      // If this is the second card flipped
      if (_flippedCards.length == 2) {
        _moves++;
        _checkMatch();
      }
    });
  }

  void _checkMatch() async {
    // Lock the board while checking
    _lockBoard = true;
    
    // Check if the two flipped cards match
    final firstCard = _flippedCards[0];
    final secondCard = _flippedCards[1];
    
    if (firstCard.pairId == secondCard.pairId) {
      // Match found
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() {
        // Mark both cards as matched
        final index1 = _cards.indexWhere((c) => c.id == firstCard.id);
        final index2 = _cards.indexWhere((c) => c.id == secondCard.id);
        
        _cards[index1] = _cards[index1].copyWith(isMatched: true);
        _cards[index2] = _cards[index2].copyWith(isMatched: true);
        
        _matchedPairs++;
        
        // Check if game is complete
        if (_matchedPairs == _totalPairs) {
          _gameComplete();
        }
      });
    } else {
      // No match - flip the cards back after a delay
      await Future.delayed(const Duration(milliseconds: 1000));
      setState(() {
        final index1 = _cards.indexWhere((c) => c.id == firstCard.id);
        final index2 = _cards.indexWhere((c) => c.id == secondCard.id);
        
        if (index1 >= 0 && index1 < _cards.length) {
          _cards[index1] = _cards[index1].copyWith(isFlipped: false);
        }
        
        if (index2 >= 0 && index2 < _cards.length) {
          _cards[index2] = _cards[index2].copyWith(isFlipped: false);
        }
      });
    }
    
    // Clear flipped cards and unlock the board
    _flippedCards = [];
    _lockBoard = false;
  }

  void _gameComplete() {
    _isGameFinished = true;
    _stopTimer();
    
    // Navigate to results screen after a short delay
    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => ResultsScreen(
            timeElapsed: _timeElapsed,
            moves: _moves,
            difficulty: widget.difficulty,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      );
    });
  }

  void _restartGame() {
    _stopTimer();
    setState(() {
      _initializeGame();
    });
  }

  void _navigateToHome() {
    _stopTimer();
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(-1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gridSize = GameUtils.getGridSize(widget.difficulty);
    final cardSize = _calculateCardSize(context, gridSize);
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Game info panel
              GameInfoPanel(
                moves: _moves,
                timeElapsed: _timeElapsed,
                difficulty: widget.difficulty,
                onRestart: _restartGame,
                onHome: _navigateToHome,
              ).animate().fadeIn(duration: 400.ms),
              
              const SizedBox(height: 16),
              
              // Game board
              Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gridSize,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: _cards.length,
                      itemBuilder: (context, index) {
                        return AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            // Staggered appearance animation
                            final delay = (index / _cards.length) * 0.5;
                            final scale = Tween<double>(begin: 0.0, end: 1.0)
                                .animate(
                                  CurvedAnimation(
                                    parent: _animationController,
                                    curve: Interval(
                                      delay, 
                                      delay + 0.4,
                                      curve: Curves.easeOutBack,
                                    ),
                                  ),
                                ).value;
                                
                            return Transform.scale(
                              scale: scale,
                              child: MemoryCardWidget(
                                card: _cards[index],
                                onCardPressed: _onCardPressed,
                                lockBoard: _lockBoard,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _calculateCardSize(BuildContext context, int gridSize) {
    // Calculate size based on available space and grid size
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = 16.0 * 2; // Padding on both sides
    final spacing = 8.0 * (gridSize - 1); // Spacing between cards
    
    return (screenWidth - padding - spacing) / gridSize;
  }
}