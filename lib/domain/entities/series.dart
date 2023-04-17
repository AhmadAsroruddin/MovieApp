import 'package:equatable/equatable.dart';

class Series extends Equatable {
  Series(
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
      required this.originalName,
      required this.jenis});

  Series.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
    required this.jenis,
  });

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
  String jenis;

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
