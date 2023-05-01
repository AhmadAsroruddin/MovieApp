import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_now_playing_series.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'series_list_state.dart';

class SeriesListCubit extends Cubit<SeriesListState> {
  GetNowPlayingSeries getNowPlayingSeries;

  SeriesListCubit(this.getNowPlayingSeries) : super(SeriesListEmpty());

  Future<void> fetchNowPlayingSeries() async {
    emit(SeriesListLoading());

    final nowPlayingMovies = await getNowPlayingSeries.execute();

    nowPlayingMovies.fold((failure) {
      emit(SeriesListError(failure.message));
    }, (data) {
      emit(SeriesListHasData(data));
    });
  }

  addListener(Null Function() param0) {}
}
