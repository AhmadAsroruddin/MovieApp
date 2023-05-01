import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/presentation/bloc/movies/movies_watchList_bloc.dart';
import 'package:ditonton/presentation/bloc/movies/movies_watchList_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_watchList_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late MoviesWatchListCubit provider;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    provider = MoviesWatchListCubit(mockGetWatchlistMovies)..addListener(() {
        listenerCallCount += 1;
      });
  });

  group('now playing movies', () {
    test('initialState should be Empty', () {
      expect(provider.state, equals(MoviesWatchListEmpty()));
    });

    blocTest<MoviesWatchListCubit, MoviesWatchListState>(
      "Should emit [Loading, HasDataNowPlayinMovies]",
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return provider;
      },
      act: (bloc) => bloc.fetchWatchListMovies(),
      expect: () =>
          [MoviesWatchListLoading(), MoviesWatchListHasData(testMovieList)],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );

    blocTest<MoviesWatchListCubit, MoviesWatchListState>(
      "Should emit erroe when no data getted ",
      build: () {
        when(mockGetWatchlistMovies.execute()).thenAnswer(
          (_) async => Left(
            ServerFailure('Server Failure'),
          ),
        );
        return provider;
      },
      act: (bloc) => bloc.fetchWatchListMovies(),
      expect: () => [MoviesWatchListLoading(), MoviesWatchListError('Server Failure')],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );
  });
}
