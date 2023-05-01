import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

abstract class MoviesWatchListState extends Equatable {
  const MoviesWatchListState();

  @override
  List<Object> get props => [];
}

class MoviesWatchListEmpty extends MoviesWatchListState {}

class MoviesWatchListLoading extends MoviesWatchListState {}

class MoviesWatchListError extends MoviesWatchListState {
  final String message;

  MoviesWatchListError(this.message);

  @override
  List<Object> get props => [message];
}

class MoviesWatchListHasData extends MoviesWatchListState {
  final List<Movie> result;

  MoviesWatchListHasData(
    this.result,
  );

  @override
  List<Object> get props => [result];
}
