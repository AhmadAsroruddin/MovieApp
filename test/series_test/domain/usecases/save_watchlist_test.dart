import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/saveSeries_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlist usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = SaveWatchlist(mockSeriesRepository);
  });

  test('should save Series to the repository', () async {
    // arrange
    when(mockSeriesRepository.saveWatchlist(testSeriesDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testSeriesDetail);
    // assert
    verify(mockSeriesRepository.saveWatchlist(testSeriesDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
