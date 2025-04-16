# 🧠 Memory Match Game – Flutter Project

A classic card matching game built with Flutter. Test your memory by flipping cards to find matching pairs across three difficulty levels. Features smooth animations, a modern dark theme, and performance tracking with a star rating system.

---

## ✨ Features

- **Three Difficulty Levels**
  - Easy (4×4), Medium (6×6), Hard (8×8)
- **Smooth Animations**
  - Card flips, board transitions, and victory effects
- **Performance Tracking**
  - Time elapsed and move count
- **Results Screen**
  - Displays score and star rating (1–5 stars)
- **Responsive Design**
  - Optimized for all mobile screen sizes
- **Dark Theme UI**
  - Modern look with vibrant card colors
- **Game Controls**
  - Restart or return to home anytime

---

## 🛠️ Technical Details

- **Built With:** Flutter 3.x
- **State Management:** `setState`
- **Animations:** [`flutter_animate`](https://pub.dev/packages/flutter_animate)
- **Architecture:** Clean widget separation (models, utils, screens)

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_animate: ^4.2.0
  google_fonts: ^6.1.0
📱 Screens
Home Screen – Difficulty selection with animated logo

Game Screen – Interactive game board with stats panel

Results Screen – Performance summary with rating

🚀 Getting Started
✅ Prerequisites
Flutter SDK (latest stable)

Dart SDK

Android Studio / VSCode with Flutter plugin

📥 Installation
<details> <summary>Setup Instructions</summary>
bash
Copy
Edit
# Clone the repository
git clone https://github.com/your-username/memory-match-game.git

# Navigate to the project directory
cd memory-match-game

# Install dependencies
flutter pub get

# Run the app
flutter run
</details>
📂 Project Structure
<details> <summary>Click to view structure</summary>
plaintext
Copy
Edit
lib/
├── config/
│   └── theme.dart               # App theme and colors
├── models/
│   └── card_model.dart          # Memory card data model
├── screens/
│   ├── game_screen.dart         # Main game screen
│   ├── home_screen.dart         # Home/difficulty selection
│   └── results_screen.dart      # Game results display
├── utils/
│   └── game_utils.dart          # Game logic and utilities
├── widgets/
│   ├── difficulty_selector.dart # Difficulty selection UI
│   ├── game_info_panel.dart     # Game stats panel
│   └── memory_card.dart         # Card widget
└── main.dart                    # App entry point
</details>
🕹️ How to Play
Select a difficulty level on the home screen

Tap cards to flip and find matching pairs

Match all pairs to complete the game

View your results and star rating

Try again to improve your score!

📊 Scoring System
⭐ Rating: Based on time + number of moves

🧠 Performance: Compared to expected values for each difficulty

💯 Max rating: 5 stars

🎮 Possible Future Features
Sound effects & background music

Global/local leaderboard with Firebase

Multiple card themes (emoji, animals, numbers)

Accessibility improvements

Adaptive AI difficulty suggestions

📧 Contact
For questions or feedback, feel free to reach out:

Email: hsppersonaltechie@gmail.com

