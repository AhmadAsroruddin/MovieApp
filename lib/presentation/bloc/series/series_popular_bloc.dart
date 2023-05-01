import 'package:ditonton/domain/usecases/get_popular_series.dart';
import 'package:ditonton/presentation/bloc/series/series_popular_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeriesPopularCubit extends Cubit<SeriesPopularState> {
  GetPopularSeries getPopularSeries;

  SeriesPopularCubit(this.getPopularSeries) : super(SeriesPopularEmpty());

  Future<void> fetchPopularSeries() async {
    emit(SeriesPopularLoading());

    final nowPlayingSeries = await getPopularSeries.execute();

    nowPlayingSeries.fold((failure) {
      emit(SeriesPopularError(failure.message));
    }, (data) {
      emit(SeriesPopularHasData(data));
    });
  }

  addListener(Null Function() param0) {}
}
