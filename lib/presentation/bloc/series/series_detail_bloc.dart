import 'package:ditonton/domain/usecases/get_series_detail.dart';
import 'package:ditonton/domain/usecases/get_series_recommendations.dart';
import 'package:ditonton/domain/usecases/removeSeries_watchlist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/series_detail.dart';
import '../../../domain/usecases/get_watchlist_status.dart';
import '../../../domain/usecases/saveSeries_watchlist.dart';
import 'series_detail_state.dart';

class SeriesDetailCubit extends Cubit<SeriesDetailState> {
  final GetSeriesDetail getSeriesDetail;
  final GetSeriesRecommendations getSeriesRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  SeriesDetailCubit(
    this.getSeriesDetail,
    this.getSeriesRecommendations,
    this.getWatchListStatus,
    this.saveWatchlist,
    this.removeWatchlist,
  ) : super(SeriesDetailEmpty());

  Future<void> fetchSeriesDetail(int id) async {
    emit(SeriesDetailLoading());

    final detailResult = await getSeriesDetail.execute(id);
    final recommendationResult = await getSeriesRecommendations.execute(id);
    final isFavorite = await getWatchListStatus.execute(id);

    detailResult.fold((failure) {
      emit(SeriesDetailError(failure.message));
    }, (data) async {
      final series = data;

      recommendationResult.fold((failure) {
        emit(SeriesDetailError(failure.message));
      }, (data) {
        emit(SeriesDetailHasData(series, data, isFavorite));
      });
    });
  }

  Future<void> addWatchList(SeriesDetail movie) async {
    final result = await saveWatchlist.execute(movie);

    await result.fold(
      (failure) async {
        emit(SeriesDetailError(failure.message));
      },
      (successMessage) async {
        print("object");
      },
    );
  }

  Future<void> removeFromWatchlist(SeriesDetail series) async {
    final result = await removeWatchlist.execute(series);

    await result.fold(
      (failure) async {
        emit(SeriesDetailError(failure.message));
      },
      (data) async {
        print("success");
      },
    );
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    emit(LoadedIsFavorite(result));
  }

  addListener(Null Function() param0) {}
}
