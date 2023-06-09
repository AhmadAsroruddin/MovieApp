import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/movies/search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:mockito/mockito.dart';
import 'searchMovie_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late SearchCubit searchCubit;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchCubit = SearchCubit(mockSearchMovies);
  });

  test('initial state should be empty', () {
    expect(searchCubit.state, SearchEmpty("pencarian kosong"));
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  final tQuery = 'spiderman';

  blocTest<SearchCubit, SearchState>(
    "Should emit [Loading, HasData] when data is gotten successfully' ",
    build: () {
      when(
        mockSearchMovies.execute(tQuery),
      ).thenAnswer(
        (_) async => Right(tMovieList),
      );
      return searchCubit;
    },
    act: (bloc) => bloc.onQueryChanged(tQuery),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );

  blocTest<SearchCubit, SearchState>(
    "Should emit erroe when no data getted ",
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchCubit;
    },
    act: (bloc) => bloc.onQueryChanged(tQuery),
    wait: const Duration(milliseconds: 500),
    expect: () => [SearchLoading(), SearchError('Server Failure')],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );
}
