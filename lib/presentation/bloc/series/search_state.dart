part of 'search_bloc.dart';

abstract class SearchSeriesState extends Equatable {
  const SearchSeriesState();

  @override
  List<Object> get props => [];
}

class SearchEmpty extends SearchSeriesState {
  final String message;

  SearchEmpty(this.message);

  @override
  List<Object> get props => [message];
}

class SearchLoading extends SearchSeriesState {}

class SearchError extends SearchSeriesState {
  final String message;

  SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchHasData extends SearchSeriesState {
  final List<Series> result;

  SearchHasData(this.result);

  @override
  List<Object> get props => [result];
}
