import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/entities/movie.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchMovies _searchMovies;

  SearchCubit(this._searchMovies) : super(SearchEmpty("pencarian kosong"));
  void onQueryChanged(String query) async {
    emit(SearchLoading());

    final result = await _searchMovies.execute(query);

    result.fold((failure) {
      emit(
        SearchError(failure.message),
      );
    }, (data) {
      emit(SearchHasData(data));
    });
  }

  // SearchBloc(this._searchMovies) : super(SearchEmpty()) {
  //   on<OnQueryChanged>((event, emit) async {
  //     final query = event.query;

  //     emit(SearchLoading());
  //     final result = await _searchMovies.execute(query);

  //     result.fold(
  //       (failure) {
  //         emit(SearchError(failure.message));
  //       },
  //       (data) {
  //         emit(SearchHasData(data));
  //       },
  //     );
  //   }, transformer: debounce(const Duration(milliseconds: 500)));
  // }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
