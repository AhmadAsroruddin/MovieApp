import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movies/movie_topRated_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieTopRatedCubit extends Cubit<MovieTopRatedState> {
  GetTopRatedMovies getTopRatedMovies;

  MovieTopRatedCubit(this.getTopRatedMovies) : super(MovieTopRatedEmpty());

  Future<void> fetchTopRatedMovie() async {
    emit(MovieTopRatedLoading());

    final topRatedMovies = await getTopRatedMovies.execute();

    topRatedMovies.fold(
      (Failure) {
        emit(MovieTopRatedError(Failure.message));
      },
      (data) {
        emit(MovieTopRatedHasData(data));
      },
    );
    addListener(Null Function() param0) {}
  }

  addListener(Null Function() param0) {}
}
