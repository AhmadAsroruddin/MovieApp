import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/movie.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailEmpty extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailHasData extends MovieDetailState {
  final MovieDetail result;
  final List<Movie> recom;
  final bool isFavorite;

  MovieDetailHasData(this.result, this.recom, this.isFavorite);

  @override
  List<Object> get props => [result, recom, isFavorite];
}

class MovieRecomError extends MovieDetailState {
  final String message;

  MovieRecomError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieRecomendation extends MovieDetailState {
  final List<Movie> recomendation;

  MovieRecomendation(this.recomendation);

  @override
  List<Object> get props => [recomendation];
}

class LoadedIsFavorite extends MovieDetailState {
  final bool value = false;

  LoadedIsFavorite(value);

  @override
  List<Object> get props => [value];
}

class AddWatchList extends MovieDetailState{
  
}
class DeleteWatchList extends MovieDetailState {
  
}
