import 'package:ditonton/presentation/bloc/movie_detail_state.dart';
import 'package:ditonton/presentation/bloc/search_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/movie_detail.dart';
import '../../domain/usecases/get_movie_detail.dart';
import '../../domain/usecases/get_movie_recommendations.dart';
import '../../domain/usecases/get_watchlist_status.dart';
import '../../domain/usecases/remove_watchlist.dart';
import '../../domain/usecases/save_watchlist.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveMoviesWatchlist saveWatchlist;
  final RemoveMoviesWatchlist removeWatchlist;

  MovieDetailCubit(
    this.getMovieDetail,
    this.getMovieRecommendations,
    this.getWatchListStatus,
    this.saveWatchlist,
    this.removeWatchlist,
  ) : super(MovieDetailEmpty());

  Future<void> fetchMovieDetail(int id) async {
    emit(MovieDetailLoading());
    ;

    final detailResult = await getMovieDetail.execute(id);
    final recommendationResult = await getMovieRecommendations.execute(id);
    final isFavorite = await getWatchListStatus.execute(id);

    detailResult.fold((failure) {
      emit(MovieDetailError(failure.message));
    }, (data) async {
      final movie = data;

      recommendationResult.fold((failure) {
        emit(MovieDetailError(failure.message));
      }, (data) {
        emit(MovieDetailHasData(movie, data, isFavorite));
      });
    });
  }

  Future<void> addWatchList(MovieDetail movie) async {
    final result = await saveWatchlist.execute(movie);

    await result.fold(
      (failure) async {
        emit(MovieDetailError(failure.message));
      },
      (successMessage) async {
        print("object");
      },
    );
  }

  Future<void> removeFromWatchlist(MovieDetail movie) async {
    final result = await removeWatchlist.execute(movie);

    await result.fold(
      (failure) async {
        emit(MovieDetailError(failure.message));
      },
      (data) async {
        print("success");
      },
    );
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    emit(LoadedIsFavorite(result));
  }

  addListener(Null Function() param0) {}
}
