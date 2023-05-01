import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

abstract class MoviesPopularState extends Equatable {
  const MoviesPopularState();

  @override
  List<Object> get props => [];
}

class MoviesPopularEmpty extends MoviesPopularState {}

class MoviesPopularLoading extends MoviesPopularState {}

class MoviesPopularError extends MoviesPopularState {
  final String message;

  MoviesPopularError(this.message);

  @override
  List<Object> get props => [message];
}

class MoviesPopularHasData extends MoviesPopularState {
  final List<Movie> result;

  MoviesPopularHasData(
    this.result,
  );

  @override
  List<Object> get props => [result];
}
