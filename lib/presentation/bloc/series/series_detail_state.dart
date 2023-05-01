import 'package:equatable/equatable.dart';

import '../../../domain/entities/series.dart';
import '../../../domain/entities/series_detail.dart';

abstract class SeriesDetailState extends Equatable {
  const SeriesDetailState();

  @override
  List<Object> get props => [];
}

class SeriesDetailEmpty extends SeriesDetailState {}

class SeriesDetailLoading extends SeriesDetailState {}

class SeriesDetailError extends SeriesDetailState {
  final String message;

  SeriesDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class SeriesDetailHasData extends SeriesDetailState {
  final SeriesDetail result;
  final List<Series> recom;
  final bool isFavorite;

  SeriesDetailHasData(this.result, this.recom, this.isFavorite);

  @override
  List<Object> get props => [result, recom, isFavorite];
}

class SeriesRecomError extends SeriesDetailState {
  final String message;

  SeriesRecomError(this.message);

  @override
  List<Object> get props => [message];
}

class SeriesRecomendation extends SeriesDetailState {
  final List<Series> recomendation;

  SeriesRecomendation(this.recomendation);

  @override
  List<Object> get props => [recomendation];
}

class LoadedIsFavorite extends SeriesDetailState {
  final bool value = false;

  LoadedIsFavorite(value);

  @override
  List<Object> get props => [value];
}

class AddWatchList extends SeriesDetailState {}

class DeleteWatchList extends SeriesDetailState {}
