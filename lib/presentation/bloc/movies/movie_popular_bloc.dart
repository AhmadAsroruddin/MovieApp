import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/movies/movie_popular_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MoviesPopularCubit extends Cubit<MoviesPopularState> {
  GetPopularMovies getPopularMovies;

  MoviesPopularCubit(this.getPopularMovies) : super(MoviesPopularEmpty());

  Future<void> fetchPopularMovies() async {
    emit(MoviesPopularLoading());

    final nowPlayingMovies = await getPopularMovies.execute();

    nowPlayingMovies.fold((failure) {
      emit(MoviesPopularError(failure.message));
    }, (data) {
      emit(MoviesPopularHasData(data));
    });
  }

  addListener(Null Function() param0) {}
}
