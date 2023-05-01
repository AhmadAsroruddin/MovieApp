import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movie_list_state.dart';
import 'movies_watchList_state.dart';

class MoviesWatchListCubit extends Cubit<MoviesWatchListState> {
  GetWatchlistMovies getWatchlistMovies;

  MoviesWatchListCubit(this.getWatchlistMovies) : super(MoviesWatchListEmpty());

  Future<void> fetchWatchListMovies() async {
    emit(MoviesWatchListLoading());

    final nowPlayingMovies = await getWatchlistMovies.execute();

    nowPlayingMovies.fold((failure) {
      emit(MoviesWatchListError(failure.message));
    }, (data) {
      emit(MoviesWatchListHasData(data));
    });
  }

  addListener(Null Function() param0) {}
}
