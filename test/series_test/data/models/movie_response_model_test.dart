import 'dart:convert';

import 'package:ditonton/data/models/series_model.dart';
import 'package:ditonton/data/models/series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tSeriesModel = SeriesModel(
    firstAirDate: "2016-08-28",
    backdropPath: "/b0BckgEovxYLBbIk5xXyWYQpmlT.jpg",
    genreIds: [18],
    id: 67419,
    name: "Victoria",
    originalLanguage: "en",
    originalName: "Victoria",
    overview: "The early life of Queen Victoria, from her accession to the throne at the tender age of 18 through to her courtship and marriage to Prince Albert. Victoria went on to rule for 63 years, and was the longest-serving monarch until she was overtaken by Elizabeth II on 9th September 2016. Rufus Sewell was Victorias first prime minister; the two immediately connected and their intimate friendship became a popular source of gossip that threatened to destabilise the Government angering both Tory and Whigs alike.",
    popularity: 11.520271,
    posterPath: "/zra8NrzxaEeunRWJmUm3HZOL4sd.jpg",
    voteAverage: 1.39,
    voteCount: 9,
  );
  final tSeriesResponseModel =
      SeriesResponse(seriesList: <SeriesModel>[tSeriesModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('series_test/dummy_data/now_playing.json'));
      // act
      final result = SeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
             "firstAirDate": "2016-08-28",
            "backdropPath": "/b0BckgEovxYLBbIk5xXyWYQpmlT.jpg",
            "genreIds": [18],
            "id": 67419,
            "name": "Victoria",
            "originalLanguage": "en",
            "originalName": "Victoria",
            "overview":
                "The early life of Queen Victoria, from her accession to the throne at the tender age of 18 through to her courtship and marriage to Prince Albert. Victoria went on to rule for 63 years, and was the longest-serving monarch until she was overtaken by Elizabeth II on 9th September 2016. Rufus Sewell was Victorias first prime minister; the two immediately connected and their intimate friendship became a popular source of gossip that threatened to destabilise the Government angering both Tory and Whigs alike.",
            "popularity": 11.520271,
            "posterPath": "/zra8NrzxaEeunRWJmUm3HZOL4sd.jpg",
            "voteAverage": 1.39,
            "voteCount": 9,
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
