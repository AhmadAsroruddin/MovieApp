import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/entities/series_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'series_model.dart';

part 'series_table.g.dart';

@JsonSerializable()
class SeriesTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final String? jenis;

  SeriesTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    this.jenis = "series"
  });

  factory SeriesTable.fromEntity(SeriesDetail movie) => SeriesTable(
        id: movie.id,
        title: movie.name,
        posterPath: movie.posterPath,
        overview: movie.overview,
      );

  factory SeriesTable.fromMap(Map<String, dynamic> map) => SeriesTable(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  Map<String, dynamic> toJson() => _$SeriesTableToJson(this);

  Series toEntity() => Series.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: title,
      );
  factory SeriesTable.fromDTO(SeriesModel movie) => SeriesTable(
        id: movie.id,
        title: movie.name,
        posterPath: movie.posterPath,
        overview: movie.overview,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, posterPath, overview];
}
