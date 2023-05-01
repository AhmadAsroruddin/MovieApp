import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/movie_list_bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/movie_list_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_list_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MovieListCubit provider;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    provider = MovieListCubit(mockGetNowPlayingMovies)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieList = <Movie>[tMovie];

  group('now playing movies', () {
    test('initialState should be Empty', () {
      expect(provider.state, equals(MovieListEmpty()));
    });

    blocTest<MovieListCubit, MovieListState>(
      "Should emit [Loading, HasDataNowPlayinMovies]",
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return provider;
      },
      act: (bloc) => bloc.fetchNowPlayingMovies(),
      expect: () => [MovieListLoading(), MovieListHasDataNowPlaying(tMovieList)],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<MovieListCubit, MovieListState>(
      "Should emit erroe when no data getted ",
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure'),),);
        return provider;
      },
      act: (bloc) => bloc.fetchNowPlayingMovies(),
      expect: () => [MovieListLoading(), MovieListError('Server Failure')],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });
}
