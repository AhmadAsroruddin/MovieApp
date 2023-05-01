import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/series.dart';

abstract class SeriesPopularState extends Equatable {
  const SeriesPopularState();

  @override
  List<Object> get props => [];
}

class SeriesPopularEmpty extends SeriesPopularState {}

class SeriesPopularLoading extends SeriesPopularState {}

class SeriesPopularError extends SeriesPopularState {
  final String message;

  SeriesPopularError(this.message);

  @override
  List<Object> get props => [message];
}

class SeriesPopularHasData extends SeriesPopularState {
  final List<Series> result;

  SeriesPopularHasData(
    this.result,
  );

  @override
  List<Object> get props => [result];
}
