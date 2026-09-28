import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_watchlist_app/main.dart';
import 'package:movie_watchlist_app/models/movie.dart';
import 'package:movie_watchlist_app/data/movies_data.dart';

void main() {
  group('Movie Model Tests', () {
    test('Movie instance initializes correctly', () {
      final movie = Movie(
        title: 'Test Movie',
        posterPath: 'assets/images/inception.jpg',
        cast: ['Actor 1', 'Actor 2'],
        synopsis: 'A test synopsis',
        isWatchlisted: false,
      );

      expect(movie.title, 'Test Movie');
      expect(movie.posterPath, 'assets/images/inception.jpg');
      expect(movie.cast.length, 2);
      expect(movie.synopsis, 'A test synopsis');
      expect(movie.isWatchlisted, false);

      movie.isWatchlisted = true;
      expect(movie.isWatchlisted, true);
    });

    test('sampleMovies dataset contains required fields and valid paths', () {
      expect(sampleMovies.length, greaterThanOrEqualTo(4));
      for (final movie in sampleMovies) {
        expect(movie.title.isNotEmpty, true);
        expect(movie.posterPath.startsWith('assets/images/'), true);
        expect(movie.cast.isNotEmpty, true);
        expect(movie.synopsis.isNotEmpty, true);
      }
    });
  });

  group('Widget Navigation & UI Smoke Tests', () {
    testWidgets('HomeScreen loads and displays movie catalog',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MovieWatchlistApp());
      await tester.pumpAndSettle();

      expect(find.text('Movie Watchlist'), findsOneWidget);
      expect(find.text('Inception'), findsOneWidget);
      expect(find.text('The Matrix'), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('Tapping movie navigates to DetailsScreen',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MovieWatchlistApp());
      await tester.pumpAndSettle();

      // Tap on Inception card
      await tester.tap(find.text('Inception'));
      await tester.pumpAndSettle();

      // Should be on DetailsScreen
      expect(find.text('Cast'), findsOneWidget);
      expect(find.text('Synopsis'), findsOneWidget);
      expect(find.text('Leonardo DiCaprio'), findsOneWidget);
    });

    testWidgets('Navigating to WatchlistScreen shows watchlist view',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MovieWatchlistApp());
      await tester.pumpAndSettle();

      // Tap on watchlist icon in app bar
      await tester.tap(find.byTooltip('View Watchlist'));
      await tester.pumpAndSettle();

      expect(find.text('My Watchlist'), findsOneWidget);
    });
  });
}
