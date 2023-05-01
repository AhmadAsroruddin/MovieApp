import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/movies/movie_topRatedMovies_bloc.dart';
import 'package:ditonton/presentation/bloc/movies/movie_topRated_state.dart';
import 'package:ditonton/presentation/bloc/series/series_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/series/series_top_rated_state.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:mocktail/mocktail.dart' as mockTail;

import '../../dummy_data/dummy_objects.dart';

class MockTopRatedSeriesBloc extends MockCubit<SeriesTopRatedState>
    implements SeriesTopRatedCubit {}

class FakeTopRatedSeriesState extends Fake implements SeriesTopRatedState {}

void main() {
  late MockTopRatedSeriesBloc mockNotifier;

  setUpAll() {
    mockTail.registerFallbackValue(FakeTopRatedSeriesState);
  }

  setUp(() {
    mockNotifier = MockTopRatedSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SeriesTopRatedCubit>(
      create: (_) => mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    mockTail.when(() => mockNotifier.fetchTopRatedMovie()).thenAnswer(
        (realInvocation) async => SeriesTopRatedHasData(testSeriesList));
    mockTail
        .when(() => mockNotifier.state)
        .thenAnswer((_) => SeriesTopRatedLoading());
    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    mockTail.when(() => mockNotifier.fetchTopRatedMovie()).thenAnswer(
        (realInvocation) async => SeriesTopRatedHasData(testSeriesList));
    mockTail
        .when(() => mockNotifier.state)
        .thenAnswer((_) => SeriesTopRatedHasData(testSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    mockTail.when(() => mockNotifier.fetchTopRatedMovie()).thenAnswer(
        (realInvocation) async => SeriesTopRatedError("error_message"));
    mockTail
        .when(() => mockNotifier.state)
        .thenAnswer((_) => SeriesTopRatedError("error_message"));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
