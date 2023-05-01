import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/presentation/bloc/movies/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movies/movie_detail_state.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:mocktail/mocktail.dart' as mocktail;

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([MovieDetailCubit])
class MockDummyCubit extends MockCubit<MovieDetailState>
    implements MovieDetailCubit {}

class MovieDetailStateFake extends Fake implements MovieDetailState {}

void main() {
  late MockDummyCubit mockDummyCubit;

  setUpAll(() {
    mocktail.registerFallbackValue(MovieDetailStateFake());
  });
  setUp(() {
    mockDummyCubit = MockDummyCubit();
    mocktail
        .when(() => mockDummyCubit.state)
        .thenReturn(MovieDetailHasData(testMovieDetail, <Movie>[], false));
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MockDummyCubit>.value(
      value: mockDummyCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    
    await tester.pumpWidget(_makeTestableWidget(DetailContent(testMovieDetail, <Movie>[], false)));
    final watchlistButtonIcon = find.byIcon(Icons.add);

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    // when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
    // when(mockNotifier.movie).thenReturn(testMovieDetail);
    // when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    // when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    // when(mockNotifier.isAddedToWatchlist).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
    
  });
}
