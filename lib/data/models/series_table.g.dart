// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeriesTable _$SeriesTableFromJson(Map<String, dynamic> json) => SeriesTable(
      id: json['id'] as int,
      title: json['title'] as String?,
      posterPath: json['posterPath'] as String?,
      overview: json['overview'] as String?,
    );

Map<String, dynamic> _$SeriesTableToJson(SeriesTable instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'posterPath': instance.posterPath,
      'overview': instance.overview,
    };
