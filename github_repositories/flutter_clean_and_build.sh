#!/bin/bash
# Clean the Flutter project
flutter clean

# Get dependencies
flutter pub get

# Run build_runner
flutter pub run build_runner build --delete-conflicting-outputs

# Analyze flutter
flutter analyze
