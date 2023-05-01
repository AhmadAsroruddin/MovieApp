import 'package:ditonton/domain/entities/series.dart';
import 'package:equatable/equatable.dart';

abstract class SeriesTopRatedState extends Equatable {
  const SeriesTopRatedState();

  @override
  List<Object> get props => [];
}

class SeriesTopRatedEmpty extends SeriesTopRatedState {}

class SeriesTopRatedLoading extends SeriesTopRatedState {}

class SeriesTopRatedError extends SeriesTopRatedState {
  final String message;

  SeriesTopRatedError(this.message);

  @override
  List<Object> get props => [message];
}

class SeriesTopRatedHasData extends SeriesTopRatedState {
  final List<Series> result;

  SeriesTopRatedHasData(
    this.result,
  );

  @override
  List<Object> get props => [result];
}
