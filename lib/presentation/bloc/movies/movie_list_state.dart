import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

abstract class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object> get props => [];
}

class MovieListEmpty extends MovieListState {}

class MovieListLoading extends MovieListState {}

class MovieListError extends MovieListState {
  final String message;

  MovieListError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieListHasDataNowPlaying extends MovieListState {
  final List<Movie> result;
 
  MovieListHasDataNowPlaying(this.result,);

  @override
  List<Object> get props => [result];
}
