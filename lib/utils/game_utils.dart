import 'dart:math';
import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../models/card_model.dart';

enum GameDifficulty {
  easy, // 4x4 grid (8 pairs)
  medium, // 6x6 grid (18 pairs)
  hard, // 8x8 grid (32 pairs)
}

class GameUtils {
  static List<IconData> icons = [
    Icons.favorite,
    Icons.star,
    Icons.face,
    Icons.pets,
    Icons.emoji_emotions,
    Icons.local_pizza,
    Icons.sports_basketball,
    Icons.music_note,
    Icons.flight,
    Icons.local_fire_department,
    Icons.cake,
    Icons.wb_sunny,
    Icons.cloud,
    Icons.beach_access,
    Icons.directions_car,
    Icons.directions_bike,
    Icons.sports_football,
    Icons.sports_tennis,
    Icons.camera,
    Icons.headphones,
    Icons.movie,
    Icons.devices,
    Icons.diamond,
    Icons.emoji_nature,
    Icons.restaurant,
    Icons.sports_esports,
    Icons.palette,
    Icons.piano,
    Icons.psychology,
    Icons.science,
    Icons.rocket_launch,
    Icons.bolt,
  ];

  static int getGridSize(GameDifficulty difficulty) {
    switch (difficulty) {
      case GameDifficulty.easy:
        return 4;
      case GameDifficulty.medium:
        return 6;
      case GameDifficulty.hard:
        return 8;
    }
  }

  static int getPairCount(GameDifficulty difficulty) {
    final gridSize = getGridSize(difficulty);
    return (gridSize * gridSize) ~/ 2;
  }

  static List<MemoryCard> generateCards(GameDifficulty difficulty) {
    final random = Random();
    final pairCount = getPairCount(difficulty);
    
    // Select random icons from our icon list
    final selectedIcons = List<IconData>.from(icons)
      ..shuffle()
      ..take(pairCount);
    
    // Create pairs of cards
    final List<MemoryCard> cards = [];
    
    for (var i = 0; i < pairCount; i++) {
      final icon = i < selectedIcons.length ? selectedIcons[i] : icons[i % icons.length];
      final color = AppTheme.cardColors[i % AppTheme.cardColors.length];
      
      // Create two cards with the same pair ID
      cards.add(MemoryCard(
        id: i * 2,
        pairId: i,
        color: color,
        icon: icon,
      ));
      
      cards.add(MemoryCard(
        id: i * 2 + 1,
        pairId: i,
        color: color,
        icon: icon,
      ));
    }
    
    // Shuffle the cards
    cards.shuffle();
    
    // Assign sequential IDs after shuffling
    for (var i = 0; i < cards.length; i++) {
      cards[i] = cards[i].copyWith(id: i);
    }
    
    return cards;
  }

  static String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}