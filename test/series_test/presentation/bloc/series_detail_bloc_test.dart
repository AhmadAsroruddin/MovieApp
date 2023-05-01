import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_series_detail.dart';
import 'package:ditonton/domain/usecases/get_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/removeSeries_watchlist.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/saveSeries_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movies/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movies/movie_detail_state.dart';
import 'package:ditonton/presentation/bloc/series/series_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/series/series_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'series_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetSeriesDetail,
  GetSeriesRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late SeriesDetailCubit seriesDetailCubit;
  late MockGetSeriesDetail mockGetSeriesDetail;
  late MockGetSeriesRecommendations mockGetSeriesRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetSeriesDetail = MockGetSeriesDetail();
    mockGetSeriesRecommendations = MockGetSeriesRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    seriesDetailCubit = SeriesDetailCubit(
      mockGetSeriesDetail,
      mockGetSeriesRecommendations,
      mockGetWatchlistStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;

  final tSeries = Series(
      posterPath: "/zra8NrzxaEeunRWJmUm3HZOL4sd.jpg",
      popularity: 11.520271,
      id: 67419,
      backdropPath: "/b0BckgEovxYLBbIk5xXyWYQpmlT.jpg",
      voteAverage: 1.39,
      overview:
          "The early life of Queen Victoria, from her accession to the throne at the tender age of 18 through to her courtship and marriage to Prince Albert. Victoria went on to rule for 63 years, and was the longest-serving monarch until she was overtaken by Elizabeth II on 9th September 2016. Rufus Sewell was Victoria’s first prime minister; the two immediately connected and their intimate friendship became a popular source of gossip that threatened to destabilise the Government – angering both Tory and Whigs alike.",
      firstAirDate: "2016-08-28",
      genreIds: [18],
      originalLanguage: "en",
      voteCount: 9,
      name: "Victoria",
      originalName: "Victoria",
      jenis: "series");
  final tSeriess = <Series>[tSeries];

  void _arrangeUsecase() {
    when(mockGetSeriesDetail.execute(tId))
        .thenAnswer((_) async => Right(testSeriesDetail));
    when(mockGetSeriesRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tSeriess));
  }

  blocTest<SeriesDetailCubit, SeriesDetailState>(
    "Should emit [Loading, HasData] when data is gotten successfully' ",
    build: () {
      when(mockGetSeriesDetail.execute(tId))
          .thenAnswer((_) async => Right(testSeriesDetail));
      when(mockGetSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tSeriess));
      when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
      return seriesDetailCubit;
    },
    act: (bloc) => bloc.fetchSeriesDetail(tId),
    expect: () => [
      SeriesDetailLoading(),
      SeriesDetailHasData(testSeriesDetail, tSeriess, true),
    ],
    verify: (bloc) {
      verify(mockGetSeriesDetail.execute(tId));
    },
  );
  blocTest<SeriesDetailCubit, SeriesDetailState>(
    "Should emit erroe when no data getted ",
    build: () {
      when(mockGetSeriesDetail.execute(tId)).thenAnswer((_) async => Left(
            ServerFailure('Server Failure'),
          ));
      when(mockGetSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Left(
                ServerFailure('Server Failure'),
              ));
      when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
      return seriesDetailCubit;
    },
    act: (bloc) => bloc.fetchSeriesDetail(tId),
    expect: () => [SeriesDetailLoading(), SeriesDetailError('Server Failure')],
    verify: (bloc) {
      verify(mockGetSeriesDetail.execute(tId));
    },
  );
}
