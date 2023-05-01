import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/movies/movie_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/movies/movie_popular_state.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart' as mockTail;
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';

class MockPopularMovieBloc extends MockCubit<MoviesPopularState>
    implements MoviesPopularCubit {}

class FakePopularMovieState extends Fake implements MoviesPopularState {}

void main() {
  late MockPopularMovieBloc mockNotifier;
  setUpAll() {
    mockTail.registerFallbackValue(FakePopularMovieState);
  }

  setUp(() {
    mockNotifier = MockPopularMovieBloc();
  });

  tearDown(() {
    mockNotifier.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MoviesPopularCubit>(
      create: (_) => mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    mockTail.when(() => mockNotifier.fetchPopularMovies()).thenAnswer(
        (realInvocation) async => MoviesPopularHasData(testMovieList));
    mockTail
        .when(() => mockNotifier.state)
        .thenAnswer((_) => MoviesPopularLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    mockTail.when(() => mockNotifier.fetchPopularMovies()).thenAnswer(
        (realInvocation) async => MoviesPopularHasData(testMovieList));
    mockTail
        .when(() => mockNotifier.state)
        .thenAnswer((_) => MoviesPopularHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    mockTail.when(() => mockNotifier.fetchPopularMovies()).thenAnswer(
        (realInvocation) async => MoviesPopularError("error_message"));
    mockTail
        .when(() => mockNotifier.state)
        .thenAnswer((_) => MoviesPopularError("error_message"));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
