import 'package:ditonton/domain/entities/series.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class SeriesModel extends Equatable {
  SeriesModel(
      {required this.backdropPath,
      required this.genreIds,
      required this.id,
      required this.firstAirDate,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.voteAverage,
      required this.voteCount,
      required this.name,
      required this.originalLanguage,
      required this.originalName});

  String? posterPath;
  String? backdropPath;
  String? overview;
  String? firstAirDate;
  String? originalLanguage;
  String? name;
  String? originalName;
  double? popularity;
  int id;
  double? voteAverage;
  int? voteCount;
  List<int>? genreIds;

  factory SeriesModel.fromJson(Map<String, dynamic> json) => SeriesModel(
        backdropPath: json['backdrop_path'] as String?,
        genreIds:
            (json['genre_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
        id: json['id'] as int,
        firstAirDate: json['first_air_date'] as String?,
        overview: json['overview'] as String?,
        popularity: (json['popularity'] as num?)?.toDouble(),
        posterPath: json['poster_path'] as String?,
        voteAverage: (json['vote_average'] as num?)?.toDouble(),
        voteCount: json['vote_count'] as int?,
        name: json['name'] as String?,
        originalLanguage: json['original_language'] as String?,
        originalName: json['original_name'] as String?,
      );

  Map<String, dynamic> toJson() =>  <String, dynamic>{
        'posterPath': this.posterPath,
        'backdropPath': this.backdropPath,
        'overview': this.overview,
        'firstAirDate': this.firstAirDate,
        'originalLanguage': this.originalLanguage,
        'name': this.name,
        'originalName': this.originalName,
        'popularity': this.popularity,
        'id': this.id,
        'voteAverage': this.voteAverage,
        'voteCount': this.voteCount,
        'genreIds': this.genreIds,
      };

  Series toEntity() {
    return Series(
      firstAirDate: this.firstAirDate,
      backdropPath: this.backdropPath,
      genreIds: this.genreIds,
      id: this.id,
      name: this.name,
      originalLanguage: this.originalLanguage,
      originalName: this.originalName,
      overview: this.overview,
      popularity: this.popularity,
      posterPath: this.posterPath,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

  @override
  List<Object?> get props => [
        backdropPath,
        genreIds,
        id,
        firstAirDate,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
        name,
        originalLanguage,
        originalName
      ];
}
