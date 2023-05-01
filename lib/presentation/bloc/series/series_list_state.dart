import 'package:ditonton/domain/entities/series.dart';
import 'package:equatable/equatable.dart';

abstract class SeriesListState extends Equatable {
  const SeriesListState();

  @override
  List<Object> get props => [];
}

class SeriesListEmpty extends SeriesListState {}

class SeriesListLoading extends SeriesListState {}

class SeriesListError extends SeriesListState {
  final String message;

  SeriesListError(this.message);

  @override
  List<Object> get props => [message];
}

class SeriesListHasData extends SeriesListState {
  final List<Series> result;

  SeriesListHasData(
    this.result,
  );

  @override
  List<Object> get props => [result];
}
