import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/removeSeries_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlist usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = RemoveWatchlist(mockSeriesRepository);
  });

  test('should remove watchlist Series from repository', () async {
    // arrange
    when(mockSeriesRepository.removeWatchlist(testSeriesDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testSeriesDetail);
    // assert
    verify(mockSeriesRepository.removeWatchlist(testSeriesDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
