import 'package:ditonton/domain/entities/series_detail.dart';
import 'package:ditonton/domain/usecases/get_series_detail.dart';
import 'package:ditonton/domain/usecases/get_series_recommendations.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/removeSeries_watchlist.dart';
import 'package:ditonton/domain/usecases/saveSeries_watchlist.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/series.dart';

class SeriesDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetSeriesDetail getSeriesDetail;
  final GetSeriesRecommendations getSeriesRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  SeriesDetailNotifier({
    required this.getSeriesDetail,
    required this.getSeriesRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  });

  late SeriesDetail _series;
  SeriesDetail get series => _series;

  RequestState _seriesState = RequestState.Empty;
  RequestState get seriesState => _seriesState;

  List<Series> _seriesRecommendations = [];
  List<Series> get seriesRecommendations => _seriesRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchSeriesDetail(int id) async {
    _seriesState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getSeriesDetail.execute(id);
    final recommendationResult = await getSeriesRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _seriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (Series) {
        _recommendationState = RequestState.Loading;
        _series = Series;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (Seriess) {
            _recommendationState = RequestState.Loaded;
            _seriesRecommendations = Seriess;
          },
        );
        _seriesState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(SeriesDetail Series) async {
    final result = await saveWatchlist.execute(Series);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(Series.id);
  }

  Future<void> removeFromWatchlist(SeriesDetail Series) async {
    final result = await removeWatchlist.execute(Series);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(Series.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
