// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeriesDetailResponse _$SeriesDetailResponseFromJson(
        Map<String, dynamic> json) =>
    SeriesDetailResponse(
      backdrop_path: json['backdrop_path'] as String,
      first_air_date: DateTime.parse(json['first_air_date'] as String),
      genres: (json['genres'] as List<dynamic>)
          .map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      homepage: json['homepage'] as String,
      id: json['id'] as int,
      in_production: json['in_production'] as bool,
      languages:
          (json['languages'] as List<dynamic>).map((e) => e as String).toList(),
      last_air_date: DateTime.parse(json['last_air_date'] as String),
      name: json['name'] as String,
      next_episode_to_air: json['next_episode_to_air'],
      number_of_episodes: json['number_of_episodes'] as int,
      number_of_seasons: json['number_of_seasons'] as int,
      origin_country: (json['origin_country'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      original_language: json['original_language'] as String,
      original_name: json['original_name'] as String,
      overview: json['overview'] as String,
      popularity: (json['popularity'] as num).toDouble(),
      poster_path: json['poster_path'] as String,
      status: json['status'] as String,
      tagline: json['tagline'] as String,
      type: json['type'] as String,
      vote_average: (json['vote_average'] as num).toDouble(),
      vote_count: json['vote_count'] as int,
    );

Map<String, dynamic> _$SeriesDetailResponseToJson(
        SeriesDetailResponse instance) =>
    <String, dynamic>{
      'backdrop_path': instance.backdrop_path,
      'first_air_date': instance.first_air_date.toIso8601String(),
      'genres': instance.genres,
      'homepage': instance.homepage,
      'id': instance.id,
      'in_production': instance.in_production,
      'languages': instance.languages,
      'last_air_date': instance.last_air_date.toIso8601String(),
      'name': instance.name,
      'next_episode_to_air': instance.next_episode_to_air,
      'number_of_episodes': instance.number_of_episodes,
      'number_of_seasons': instance.number_of_seasons,
      'origin_country': instance.origin_country,
      'original_language': instance.original_language,
      'original_name': instance.original_name,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.poster_path,
      'status': instance.status,
      'tagline': instance.tagline,
      'type': instance.type,
      'vote_average': instance.vote_average,
      'vote_count': instance.vote_count,
    };
