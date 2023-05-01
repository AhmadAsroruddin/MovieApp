import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/search_series.dart';
import 'package:ditonton/presentation/bloc/series/search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:mockito/mockito.dart';
import 'search_series_bloc_test.mocks.dart';

@GenerateMocks([SearchSeries])
void main() {
  late SearchSeriesCubit searchSeriesCubit;
  late MockSearchSeries mockSearchSeries;

  setUp(() {
    mockSearchSeries = MockSearchSeries();
    searchSeriesCubit = SearchSeriesCubit(mockSearchSeries);
  });

  test('initial state should be empty', () {
    expect(searchSeriesCubit.state, SearchEmpty("pencarian kosong"));
  });

  final tMovieModel = Series(
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
  final tMovieList = <Series>[tMovieModel];
  final tQuery = 'spiderman';

  blocTest<SearchSeriesCubit, SearchSeriesState>(
    "Should emit [Loading, HasData] when data is gotten successfully' ",
    build: () {
      when(
        mockSearchSeries.execute(tQuery),
      ).thenAnswer(
        (_) async => Right(tMovieList),
      );
      return searchSeriesCubit;
    },
    act: (bloc) => bloc.onQueryChanged(tQuery),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockSearchSeries.execute(tQuery));
    },
  );

  blocTest<SearchSeriesCubit, SearchSeriesState>(
    "Should emit erroe when no data getted ",
    build: () {
      when(mockSearchSeries.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchSeriesCubit;
    },
    act: (bloc) => bloc.onQueryChanged(tQuery),
    wait: const Duration(milliseconds: 500),
    expect: () => [SearchLoading(), SearchError('Server Failure')],
    verify: (bloc) {
      verify(mockSearchSeries.execute(tQuery));
    },
  );
}
