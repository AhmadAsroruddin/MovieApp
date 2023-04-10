import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/series_table.dart';

abstract class MovieLocalDataSource {
  Future<String> insertWatchlist(SeriesTable movie);
  Future<String> removeWatchlist(SeriesTable movie);
  Future<SeriesTable?> getMovieById(int id);
  Future<List<SeriesTable>> getWatchlistMovies();
  Future<void> cacheNowPlayingMovies(List<SeriesTable> movies);
  Future<List<SeriesTable>> getCachedNowPlayingMovies();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(SeriesTable movie) async {
    try {
      await databaseHelper.insertWatchlist(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(SeriesTable movie) async {
    try {
      await databaseHelper.removeWatchlist(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<SeriesTable?> getMovieById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return SeriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<SeriesTable>> getWatchlistMovies() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => SeriesTable.fromMap(data)).toList();
  }
  
  @override
  Future<void> cacheNowPlayingMovies(List<SeriesTable> movies) async{
    await databaseHelper.insertCacheTransaction(movies, 'now playing');
    await databaseHelper.clearCache('now playing');
    await databaseHelper.insertCacheTransaction(movies, 'now playing');
  }
  
  @override
  Future<List<SeriesTable>> getCachedNowPlayingMovies() async{
    final result = await databaseHelper.getCacheMovies('now playing');
     if (result.length > 0) {
      return result.map((data) => SeriesTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }
}
