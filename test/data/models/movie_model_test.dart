import 'package:ditonton/data/models/series_model.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeriesModel = SeriesModel(
   firstAirDate: '9 november 2021',
    backdropPath: 'backdropPath',
    genreIds: [1,2,3],
    id:123,
    name: "Film",
    originalLanguage: "Indonesia",
    originalName: "filmss",
    overview: "lorem  asdlkakjsbfjkbfakhdvflavsdfl vdvyfaougdsfuasdlf",
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tSeries = Series(
    firstAirDate: '9 november 2021',
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 123,
    name: "Film",
    originalLanguage: "Indonesia",
    originalName: "filmss",
    overview: "lorem  asdlkakjsbfjkbfakhdvflavsdfl vdvyfaougdsfuasdlf",
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  test('should be a subclass of Movie entity', () async {
    final result = tSeriesModel.toEntity();
    expect(result, tSeries);
  });
}
