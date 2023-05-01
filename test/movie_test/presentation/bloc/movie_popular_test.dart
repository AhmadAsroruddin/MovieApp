import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/movie_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_popular_state.dart';
import 'package:ditonton/presentation/bloc/movie_topRatedMovies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_topRated_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_popular_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late MoviesPopularCubit blocProvider;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularMovies = MockGetPopularMovies();
    blocProvider = MoviesPopularCubit(mockGetPopularMovies)
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
      expect(blocProvider.state, equals(MoviesPopularEmpty()));
    });

    blocTest<MoviesPopularCubit, MoviesPopularState>(
      "Should emit [Loading, HasDataNowPlayinMovies]",
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return blocProvider;
      },
      act: (bloc) => bloc.fetchPopularMovies(),
      expect: () =>
          [MoviesPopularLoading(), MoviesPopularHasData(tMovieList)],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<MoviesPopularCubit, MoviesPopularState>(
      "Should emit erroe when no data getted ",
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
          (_) async => Left(
            ServerFailure('Server Failure'),
          ),
        );
        return blocProvider;
      },
      act: (bloc) => bloc.fetchPopularMovies(),
      expect: () => [MoviesPopularLoading(), MoviesPopularError('Server Failure')],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });
}
