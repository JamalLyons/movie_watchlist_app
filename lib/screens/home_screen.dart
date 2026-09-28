import 'package:flutter/material.dart';
import '../data/movies_data.dart';
import '../models/movie.dart';
import 'details_screen.dart';
import 'watchlist_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int get _watchlistCount =>
      sampleMovies.where((movie) => movie.isWatchlisted).length;

  Future<void> _openDetails(Movie movie) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailsScreen(movie: movie),
      ),
    );
    // Refresh UI to reflect changes in watchlist state made on DetailsScreen
    setState(() {});
  }

  Future<void> _openWatchlist() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const WatchlistScreen(),
      ),
    );
    // Refresh UI when returning from WatchlistScreen
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.movie_filter_rounded, color: Colors.amber),
            SizedBox(width: 8),
            Text('Movie Watchlist'),
          ],
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.bookmarks_rounded),
                tooltip: 'View Watchlist',
                onPressed: _openWatchlist,
              ),
              if (_watchlistCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      '$_watchlistCount',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: sampleMovies.length,
        itemBuilder: (context, index) {
          final movie = sampleMovies[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: movie.isWatchlisted
                    ? Colors.amber.withValues(alpha: 0.5)
                    : theme.dividerColor.withValues(alpha: 0.1),
                width: movie.isWatchlisted ? 1.5 : 1,
              ),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => _openDetails(movie),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Poster thumbnail
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        movie.posterPath,
                        width: 80,
                        height: 110,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 80,
                            height: 110,
                            color: Colors.grey.shade800,
                            child: const Icon(
                              Icons.broken_image,
                              color: Colors.white54,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Movie details info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  movie.title,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              // Watchlist quick toggle
                              IconButton(
                                icon: Icon(
                                  movie.isWatchlisted
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: Colors.amber,
                                ),
                                tooltip: movie.isWatchlisted
                                    ? 'Remove from Watchlist'
                                    : 'Add to Watchlist',
                                onPressed: () {
                                  setState(() {
                                    movie.isWatchlisted = !movie.isWatchlisted;
                                  });
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        movie.isWatchlisted
                                            ? '"${movie.title}" added to Watchlist'
                                            : '"${movie.title}" removed from Watchlist',
                                      ),
                                      duration: const Duration(seconds: 2),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Cast: ${movie.cast.take(3).join(", ")}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.textTheme.bodySmall?.color
                                  ?.withValues(alpha: 0.7),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            movie.synopsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),

                    // Chevron trailing icon
                    const Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Icon(
                          Icons.chevron_right,
                          color: Colors.white38,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openWatchlist,
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        icon: const Icon(Icons.bookmark),
        label: Text(
          _watchlistCount == 0
              ? 'View Watchlist'
              : 'Watchlist ($_watchlistCount)',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
