import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/series_table.dart';

abstract class SeriesLocalDataSource {
  Future<String> insertWatchlist(SeriesTable series);
  Future<String> removeWatchlist(SeriesTable series);
  Future<SeriesTable?> getSeriesById(int id);
  Future<List<SeriesTable>> getWatchlistSeriess();
  Future<void> cacheNowPlayingSeries(List<SeriesTable> series);
  Future<List<SeriesTable>> getCachedNowPlayingSeriess();
}

class SeriesLocalDataSourceImpl implements SeriesLocalDataSource {
  final DatabaseHelper databaseHelper;

  SeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(SeriesTable series) async {
    try {
      await databaseHelper.insertWatchlist(series);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(SeriesTable series) async {
    try {
      await databaseHelper.removeWatchlist(series);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<SeriesTable?> getSeriesById(int id) async {
    final result = await databaseHelper.getSeriesById(id);
    if (result != null) {
      return SeriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<SeriesTable>> getWatchlistSeriess() async {
    final result = await databaseHelper.getWatchlistSeries();
    return result.map((data) => SeriesTable.fromMap(data)).toList();
  }
  
  @override
  Future<void> cacheNowPlayingSeries(List<SeriesTable> Seriess) async{
    await databaseHelper.insertCacheTransaction(Seriess, 'now playing');
    await databaseHelper.clearCache('now playing');
    await databaseHelper.insertCacheTransaction(Seriess, 'now playing');
  }
  
  @override
  Future<List<SeriesTable>> getCachedNowPlayingSeriess() async{
    final result = await databaseHelper.getCacheSeries('now playing');
     if (result.length > 0) {
      return result.map((data) => SeriesTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }
  
  
}
