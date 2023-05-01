import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/movies/movie_topRatedMovies_bloc.dart';
import 'package:ditonton/presentation/bloc/movies/movie_topRated_state.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:mocktail/mocktail.dart' as mockTail;

import '../../dummy_data/dummy_objects.dart';

class MockTopRatedMovieBloc extends MockCubit<MovieTopRatedState>
    implements MovieTopRatedCubit {}

class FakeTopRatedMovieState extends Fake implements MovieTopRatedState {}

void main() {
  late MockTopRatedMovieBloc mockNotifier;

  setUpAll() {
    mockTail.registerFallbackValue(FakeTopRatedMovieState);
  }

  setUp(() {
    mockNotifier = MockTopRatedMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieTopRatedCubit>(
      create: (_) => mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    mockTail.when(() => mockNotifier.fetchTopRatedMovie()).thenAnswer(
        (realInvocation) async => MovieTopRatedHasData(testMovieList));
    mockTail
        .when(() => mockNotifier.state)
        .thenAnswer((_) => MovieTopRatedLoading());
    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    mockTail.when(() => mockNotifier.fetchTopRatedMovie()).thenAnswer(
        (realInvocation) async => MovieTopRatedHasData(testMovieList));
    mockTail
        .when(() => mockNotifier.state)
        .thenAnswer((_) => MovieTopRatedHasData(testMovieList));


    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    mockTail.when(() => mockNotifier.fetchTopRatedMovie()).thenAnswer(
        (realInvocation) async => MovieTopRatedError("error_message"));
    mockTail
        .when(() => mockNotifier.state)
        .thenAnswer((_) => MovieTopRatedError("error_message"));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
