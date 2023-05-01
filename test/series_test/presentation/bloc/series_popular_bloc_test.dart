import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/get_popular_series.dart';
import 'package:ditonton/presentation/bloc/movies/movie_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/movies/movie_popular_state.dart';
import 'package:ditonton/presentation/bloc/series/series_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/series/series_popular_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../bloc/series_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularSeries])
void main() {
  late MockGetPopularSeries mockGetPopularSeries;
  late SeriesPopularCubit blocProvider;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularSeries = MockGetPopularSeries();
    blocProvider = SeriesPopularCubit(mockGetPopularSeries)
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
      expect(blocProvider.state, equals(SeriesPopularEmpty()));
    });

    blocTest<SeriesPopularCubit, SeriesPopularState>(
      "Should emit [Loading, HasDataNowPlayinMovies]",
      build: () {
        when(mockGetPopularSeries.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return blocProvider;
      },
      act: (bloc) => bloc.fetchPopularSeries(),
      expect: () => [SeriesPopularLoading(), SeriesPopularHasData(tMovieList)],
      verify: (bloc) {
        verify(mockGetPopularSeries.execute());
      },
    );

    blocTest<SeriesPopularCubit, SeriesPopularState>(
      "Should emit erroe when no data getted ",
      build: () {
        when(mockGetPopularSeries.execute()).thenAnswer(
          (_) async => Left(
            ServerFailure('Server Failure'),
          ),
        );
        return blocProvider;
      },
      act: (bloc) => bloc.fetchPopularSeries(),
      expect: () =>
          [SeriesPopularLoading(), SeriesPopularError('Server Failure')],
      verify: (bloc) {
        verify(mockGetPopularSeries.execute());
      },
    );
  });
}
