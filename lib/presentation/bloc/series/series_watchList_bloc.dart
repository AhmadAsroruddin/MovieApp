import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/presentation/bloc/series/series_watchList_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeriesWatchListCubit extends Cubit<SeriesWatchListState> {
  GetWatchlistSeries getWatchlistSeries;

  SeriesWatchListCubit(this.getWatchlistSeries) : super(SeriesWatchListEmpty());

  Future<void> fetchWatchListMovies() async {
    emit(SeriesWatchListLoading());

    final nowPlayingMovies = await getWatchlistSeries.execute();

    nowPlayingMovies.fold((failure) {
      emit(SeriesWatchListError(failure.message));
    }, (data) {
      emit(SeriesWatchListHasData(data));
    });
  }

  addListener(Null Function() param0) {}
}
