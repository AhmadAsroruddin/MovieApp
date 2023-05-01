import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movies/movie_list_bloc.dart';
import 'package:ditonton/presentation/bloc/movies/movie_list_state.dart';
import 'package:ditonton/presentation/bloc/movies/movie_topRatedMovies_bloc.dart';
import 'package:ditonton/presentation/bloc/movies/movie_topRated_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_topRated_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MovieTopRatedCubit provider;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    provider = MovieTopRatedCubit(mockGetTopRatedMovies)
      ..addListener(() {
        listenerCallCount++;
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
      expect(provider.state, equals(MovieTopRatedEmpty()));
    });

    blocTest<MovieTopRatedCubit, MovieTopRatedState>(
      "Should emit [Loading, HasDataNowPlayinMovies]",
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return provider;
      },
      act: (bloc) => bloc.fetchTopRatedMovie(),
      expect: () =>
          [MovieTopRatedLoading(), MovieTopRatedHasData(tMovieList)],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<MovieTopRatedCubit, MovieTopRatedState>(
      "Should emit erroe when no data getted ",
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
          (_) async => Left(
            ServerFailure('Server Failure'),
          ),
        );
        return provider;
      },
      act: (bloc) => bloc.fetchTopRatedMovie(),
      expect: () => [MovieTopRatedLoading(), MovieTopRatedError('Server Failure')],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });
}
