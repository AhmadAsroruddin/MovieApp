import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:equatable/equatable.dart';

abstract class SeriesWatchListState extends Equatable {
  const SeriesWatchListState();

  @override
  List<Object> get props => [];
}

class SeriesWatchListEmpty extends SeriesWatchListState {}

class SeriesWatchListLoading extends SeriesWatchListState {}

class SeriesWatchListError extends SeriesWatchListState {
  final String message;

  SeriesWatchListError(this.message);

  @override
  List<Object> get props => [message];
}

class SeriesWatchListHasData extends SeriesWatchListState {
  final List<Series> result;

  SeriesWatchListHasData(
    this.result,
  );

  @override
  List<Object> get props => [result];
}
