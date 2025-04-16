Memory Match Game - Flutter Project

📌 Overview
Memory Match is a classic card matching game built with Flutter. Test your memory by flipping cards to find matching pairs across three difficulty levels. The game features beautiful animations, a dark theme UI, and tracks your performance with time and move counts.


✨ Features
Three Difficulty Levels: Easy (4×4), Medium (6×6), and Hard (8×8) grid sizes

Smooth Animations: Card flipping, game board transitions, and victory effects

Performance Tracking: Time elapsed and move count recording

Results Screen: Shows your performance with a star rating system

Responsive Design: Works on mobile devices of all sizes

Dark Theme UI: Modern dark theme with vibrant card colors

Game Controls: Restart game or return to home screen anytime


🛠️ Technical Details
Built With: Flutter 3.x

State Management: Built-in Flutter state management (setState)

Animations: Uses flutter_animate package for sophisticated animations

Architecture: Clean widget separation with models, utilities, and screens


Dependencies:

flutter_animate: For beautiful animations

google_fonts: For custom typography


📱 Screens
Home Screen: Difficulty selection with animated logo

Game Screen: Interactive game board with info panel

Results Screen: Performance summary with star rating


🚀 Getting Started
Prerequisites
Flutter SDK (latest stable version)

Dart SDK

Android Studio/VSCode with Flutter plugin

Installation
Clone the repository:

bash
Copy
git clone https://github.com/your-username/memory-match-game.git
Navigate to the project directory:

bash
Copy
cd memory-match-game
Install dependencies:

bash
Copy
flutter pub get
Run the app:

bash
Copy
flutter run


📂 Project Structure
Copy
lib/
├── config/
│   └── theme.dart          # App theme and colors
├── models/
│   └── card_model.dart     # Memory card data model
├── screens/
│   ├── game_screen.dart    # Main game screen
│   ├── home_screen.dart    # Home/difficulty selection
│   └── results_screen.dart # Game results display
├── utils/
│   └── game_utils.dart     # Game logic and utilities
├── widgets/
│   ├── difficulty_selector.dart # Difficulty selection UI
│   ├── game_info_panel.dart    # Game stats panel
│   └── memory_card.dart        # Card widget
└── main.dart               # App entry point


📝 How to Play

Select a difficulty level

Tap cards to flip them and find matching pairs

Match all pairs to complete the game

View your results and try to improve your score!


📊 Scoring System
Rating: Based on time and moves (1-5 stars)

Performance: Compared to expected values for each difficulty


📧 Contact
For questions or feedback, please contact hsppersonaltechie@gmail.com
