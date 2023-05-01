import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_series.dart';
import 'package:ditonton/presentation/bloc/movies/movie_topRatedMovies_bloc.dart';
import 'package:ditonton/presentation/bloc/movies/movie_topRated_state.dart';
import 'package:ditonton/presentation/bloc/series/series_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/series/series_top_rated_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'series_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedSeries])
void main() {
  late MockGetTopRatedSeries mockGetTopRatedSeries;
  late SeriesTopRatedCubit provider;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedSeries = MockGetTopRatedSeries();
    provider = SeriesTopRatedCubit(mockGetTopRatedSeries)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tMovie = Series(
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

  final tMovieList = <Series>[tMovie];

  group('now playing movies', () {
    test('initialState should be Empty', () {
      expect(provider.state, equals(SeriesTopRatedEmpty()));
    });

    blocTest<SeriesTopRatedCubit, SeriesTopRatedState>(
      "Should emit [Loading, HasDataNowPlayinMovies]",
      build: () {
        when(mockGetTopRatedSeries.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return provider;
      },
      act: (bloc) => bloc.fetchTopRatedMovie(),
      expect: () => [SeriesTopRatedLoading(), SeriesTopRatedHasData(tMovieList)],
      verify: (bloc) {
        verify(mockGetTopRatedSeries.execute());
      },
    );

    blocTest<SeriesTopRatedCubit, SeriesTopRatedState>(
      "Should emit erroe when no data getted ",
      build: () {
        when(mockGetTopRatedSeries.execute()).thenAnswer(
          (_) async => Left(
            ServerFailure('Server Failure'),
          ),
        );
        return provider;
      },
      act: (bloc) => bloc.fetchTopRatedMovie(),
      expect: () =>
          [SeriesTopRatedLoading(), SeriesTopRatedError('Server Failure')],
      verify: (bloc) {
        verify(mockGetTopRatedSeries.execute());
      },
    );
  });
}
