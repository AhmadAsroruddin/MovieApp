import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/usecases/get_watchlist_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistSeries usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetWatchlistSeries(mockSeriesRepository);
  });

  // test('should get watchlist status from repository', () async {
  //   // arrange
  //   when(mockSeriesRepository.isAddedToWatchlist(1))
  //       .thenAnswer((_) async => true);
  //   // act
  //   final result = await usecase.execute();
  //   // assert
  //   expect(result, true);
  // });
}
