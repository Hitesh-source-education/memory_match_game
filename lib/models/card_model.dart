import 'package:flutter/material.dart';

class MemoryCard {
  final int id;
  final int pairId;
  final Color color;
  final IconData icon;
  bool isFlipped;
  bool isMatched;

  MemoryCard({
    required this.id,
    required this.pairId,
    required this.color,
    required this.icon,
    this.isFlipped = false,
    this.isMatched = false,
  });

  MemoryCard copyWith({
    int? id,
    int? pairId,
    Color? color,
    IconData? icon,
    bool? isFlipped,
    bool? isMatched,
  }) {
    return MemoryCard(
      id: id ?? this.id,
      pairId: pairId ?? this.pairId,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      isFlipped: isFlipped ?? this.isFlipped,
      isMatched: isMatched ?? this.isMatched,
    );
  }
}