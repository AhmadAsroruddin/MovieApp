import 'package:ditonton/domain/usecases/get_top_rated_series.dart';
import 'package:ditonton/presentation/bloc/movies/movie_topRated_state.dart';
import 'package:ditonton/presentation/bloc/series/series_top_rated_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeriesTopRatedCubit extends Cubit<SeriesTopRatedState> {
  GetTopRatedSeries getTopRatedSeries;

  SeriesTopRatedCubit(this.getTopRatedSeries) : super(SeriesTopRatedEmpty());

  Future<void> fetchTopRatedMovie() async {
    emit(SeriesTopRatedLoading());

    final topRatedMovies = await getTopRatedSeries.execute();

    topRatedMovies.fold(
      (Failure) {
        emit(SeriesTopRatedError(Failure.message));
      },
      (data) {
        emit(SeriesTopRatedHasData(data));
      },
    );
    addListener(Null Function() param0) {}
  }

  addListener(Null Function() param0) {}
}
