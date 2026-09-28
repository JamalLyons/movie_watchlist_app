# CW-02: Flutter Movie Watchlist App

A multi-screen Flutter application built for **CSC 4360/6360 — Mobile App Development**. Demonstrates navigation, state management, data passing, custom UI architecture, and asset management in Flutter.

## 📱 Features

- **HomeScreen**:
  - Scrollable catalog of movies implemented using `ListView.builder`.
  - Custom movie cards displaying poster thumbnails, title, cast highlights, synopsis snippet, and watchlist indicator.
  - Interactive watchlist count badge in the AppBar and an extended Floating Action Button for quick access to the watchlist.
  - Tappable cards that pass the selected `Movie` object to `DetailsScreen` using `Navigator.push` and `MaterialPageRoute`.
  - Immediate state reflection when returning from details or watchlist views.

- **DetailsScreen**:
  - Full-detail movie view receiving a typed `Movie` object without hardcoded values.
  - Hero poster header utilizing local assets via `Image.asset()` with fallback error handling.
  - Dynamic cast list rendered with individual Material 3 `Chip` widgets.
  - Clean synopsis typography section.
  - Interactive AppBar bookmark action and action button to toggle watchlist status with `SnackBar` notifications.

- **WatchlistScreen (Graduate Track)**:
  - Displays filtered list of movies where `movie.isWatchlisted == true`.
  - Empty state with illustration and quick-return button when no movies are watchlisted.
  - Swipe-to-dismiss (`Dismissible`) gesture to quickly remove movies from the watchlist with an `Undo` SnackBar action.
  - Ability to tap any saved movie to view its full details.

- **Asset Management**:
  - Local posters stored in `assets/images/` and declared in `pubspec.yaml`:
    - `inception.jpg`
    - `matrix.jpg`
    - `interstellar.jpg`
    - `dark_knight.jpg`
    - `parasite.jpg`
    - `spirited_away.jpg`

---

## 📂 Project Architecture

```
movie_watchlist_app/
├── assets/
│   └── images/
│       ├── dark_knight.jpg
│       ├── inception.jpg
│       ├── interstellar.jpg
│       ├── matrix.jpg
│       ├── parasite.jpg
│       └── spirited_away.jpg
├── lib/
│   ├── data/
│   │   └── movies_data.dart        # Dataset of sample movies
│   ├── models/
│   │   └── movie.dart              # Movie model definition
│   ├── screens/
│   │   ├── details_screen.dart     # Full movie details & watchlist toggle
│   │   ├── home_screen.dart        # Main movie list & watchlist entry points
│   │   └── watchlist_screen.dart   # Filtered watchlist screen (Grad feature)
│   └── main.dart                   # App entry point & Dark Cinema theme
├── test/
│   └── widget_test.dart            # Unit and widget test suite
└── pubspec.yaml                    # Dependencies & asset declarations
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.x or higher)
- Android SDK (for Android APK / emulator) or Chrome / macOS desktop

### Run Locally
```bash
# 1. Install dependencies
flutter pub get

# 2. Run analysis
flutter analyze

# 3. Run test suite
flutter test

# 4. Launch the application
flutter run
```

### Build Release APK
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

---

## 📦 Submission Artifacts

- **GitHub Repository**: [https://github.com/JamalLyons/movie_watchlist_app](https://github.com/JamalLyons/movie_watchlist_app)
- **Release APK Download**: [https://github.com/JamalLyons/movie_watchlist_app/releases/tag/v1.0.0](https://github.com/JamalLyons/movie_watchlist_app/releases/tag/v1.0.0)
- **Local APK Path**: `build/app/outputs/flutter-apk/app-release.apk`
