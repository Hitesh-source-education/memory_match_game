import 'dart:math';
import 'package:flutter/material.dart';
import '../models/card_model.dart';
import '../config/theme.dart';

class MemoryCardWidget extends StatefulWidget {
  final MemoryCard card;
  final Function(MemoryCard) onCardPressed;
  final bool lockBoard;

  const MemoryCardWidget({
    Key? key,
    required this.card,
    required this.onCardPressed,
    this.lockBoard = false,
  }) : super(key: key);

  @override
  State<MemoryCardWidget> createState() => _MemoryCardWidgetState();
}

class _MemoryCardWidgetState extends State<MemoryCardWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    
    _animation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: pi / 2)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 50.0,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: pi / 2, end: pi)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50.0,
      ),
    ]).animate(_controller);

    // Initialize animation state based on card's initial flipped state
    if (widget.card.isFlipped) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(MemoryCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (oldWidget.card.isFlipped != widget.card.isFlipped) {
      if (widget.card.isFlipped) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.lockBoard && !widget.card.isFlipped && !widget.card.isMatched) {
          widget.onCardPressed(widget.card);
        }
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value;
          final isFrontVisible = angle < pi / 2;
          
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // Perspective
              ..rotateY(angle),
            child: Container(
              decoration: BoxDecoration(
                color: isFrontVisible ? AppTheme.surfaceColor : widget.card.color,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: AnimatedOpacity(
                  opacity: widget.card.isMatched ? 0.6 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    isFrontVisible ? Icons.question_mark : widget.card.icon,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}