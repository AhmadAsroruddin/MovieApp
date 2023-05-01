import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movie_list_state.dart';

class MovieListCubit extends Cubit<MovieListState> {
  GetNowPlayingMovies getNowPlayingMovies;

  MovieListCubit(this.getNowPlayingMovies) : super(MovieListEmpty());

  Future<void> fetchNowPlayingMovies() async {
    emit(MovieListLoading());

    final nowPlayingMovies = await getNowPlayingMovies.execute();

    nowPlayingMovies.fold((failure) {
      emit(MovieListError(failure.message));
    }, (data) {
      emit(MovieListHasDataNowPlaying(data));
    });
  }

  addListener(Null Function() param0) {}
}
