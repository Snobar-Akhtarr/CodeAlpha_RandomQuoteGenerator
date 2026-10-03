# CodeAlpha_RandomQuoteGenerator

A clean and minimal Random Quote Generator app built with **Flutter** and **Dart**, created as **Task 2** of the CodeAlpha Flutter Development Internship.

## Features

- Shows a random quote as soon as the app opens
- **New Quote** button that always shows a different quote (no repeats in a row)
- Quote text and author name displayed clearly
- Smooth fade animation between quotes
- Copy quote to clipboard
- Light and dark mode
- Minimal UI with a serif quote typeface

## Tech Stack

- Flutter
- Dart
- No external packages, so it runs out of the box

## How to Run

```bash
git clone https://github.com/Snobar-Akhtarr/CodeAlpha_RandomQuoteGenerator.git
cd CodeAlpha_RandomQuoteGenerator
flutter pub get
flutter run
```

## How It Works

- Quotes are stored in a local list of `Quote` objects (text and author).
- `initState()` picks a random quote when the screen opens.
- The **New Quote** button picks a new random index, repeating the draw if it matches the current one, then calls `setState()` to update the UI.
- `AnimatedSwitcher` handles the fade transition.

## Author

**Snobar Akhtar**
GitHub: [Snobar-Akhtarr](https://github.com/Snobar-Akhtarr)
