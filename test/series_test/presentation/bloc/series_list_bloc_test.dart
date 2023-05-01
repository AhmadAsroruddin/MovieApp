import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_series.dart';
import 'package:ditonton/presentation/bloc/movies/movie_list_bloc.dart';
import 'package:ditonton/presentation/bloc/movies/movie_list_state.dart';
import 'package:ditonton/presentation/bloc/series/series_list_bloc.dart';
import 'package:ditonton/presentation/bloc/series/series_list_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'series_list_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingSeries])
void main() {
  late SeriesListCubit provider;
  late MockGetNowPlayingSeries mockGetNowPlayingSeries;

  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingSeries = MockGetNowPlayingSeries();
    provider = SeriesListCubit(mockGetNowPlayingSeries)
      ..addListener(() {
        listenerCallCount += 1;
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
      expect(provider.state, equals(SeriesListEmpty()));
    });

    blocTest<SeriesListCubit, SeriesListState>(
      "Should emit [Loading, HasDataNowPlayinMovies]",
      build: () {
        when(mockGetNowPlayingSeries.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return provider;
      },
      act: (bloc) => bloc.fetchNowPlayingSeries(),
      expect: () =>
          [SeriesListLoading(), SeriesListHasData(tMovieList)],
      verify: (bloc) {
        verify(mockGetNowPlayingSeries.execute());
      },
    );

    blocTest<SeriesListCubit, SeriesListState>(
      "Should emit erroe when no data getted ",
      build: () {
        when(mockGetNowPlayingSeries.execute()).thenAnswer(
          (_) async => Left(
            ServerFailure('Server Failure'),
          ),
        );
        return provider;
      },
      act: (bloc) => bloc.fetchNowPlayingSeries(),
      expect: () => [SeriesListLoading(), SeriesListError('Server Failure')],
      verify: (bloc) {
        verify(mockGetNowPlayingSeries.execute());
      },
    );
  });
}
