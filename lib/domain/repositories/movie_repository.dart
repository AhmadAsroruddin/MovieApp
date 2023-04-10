import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/entities/series_detail.dart';
import 'package:ditonton/common/failure.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Series>>> getNowPlayingMovies();
  Future<Either<Failure, List<Series>>> getPopularMovies();
  Future<Either<Failure, List<Series>>> getTopRatedMovies();
  Future<Either<Failure, SeriesDetail>> getMovieDetail(int id);
  Future<Either<Failure, List<Series>>> getMovieRecommendations(int id);
  Future<Either<Failure, List<Series>>> searchMovies(String query);
  Future<Either<Failure, String>> saveWatchlist(SeriesDetail movie);
  Future<Either<Failure, String>> removeWatchlist(SeriesDetail movie);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<Series>>> getWatchlistMovies();
}
