// ignore_for_file: non_constant_identifier_names

import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/series_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'series_detail_model.g.dart';

@JsonSerializable()
class SeriesDetailResponse extends Equatable {
  SeriesDetailResponse({
    required this.backdrop_path,
    required this.first_air_date,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.in_production,
    required this.languages,
    required this.last_air_date,
    required this.name,
    this.next_episode_to_air,
    required this.number_of_episodes,
    required this.number_of_seasons,
    required this.origin_country,
    required this.original_language,
    required this.original_name,
    required this.overview,
    required this.popularity,
    required this.poster_path,
    required this.status,
    required this.tagline,
    required this.type,
    required this.vote_average,
    required this.vote_count,
  });

  String backdrop_path;
  DateTime first_air_date;
  List<GenreModel> genres;
  String homepage;
  int id;
  bool in_production;
  List<String> languages;
  DateTime last_air_date;
  String name;
  dynamic next_episode_to_air;
  int number_of_episodes;
  int number_of_seasons;
  List<String> origin_country;
  String original_language;
  String original_name;
  String overview;
  double popularity;
  String poster_path;
  String status;
  String tagline;
  String type;
  double vote_average;
  int vote_count;

  factory SeriesDetailResponse.fromJson(Map<String, dynamic> json) =>_$SeriesDetailResponseFromJson(json);
  

  SeriesDetail toEntity() {
    return SeriesDetail(
        backdropPath: this.backdrop_path,
        genres: this.genres.map((genre) => genre.toEntity()).toList(),
        id: this.id,
        overview: this.overview,
        posterPath: this.poster_path,
        voteAverage: this.vote_average,
        voteCount: this.vote_count,
        firstAirDate: this.first_air_date,
        homepage: this.homepage,
        inProduction: this.in_production,
        languages: this.languages,
        lastAirDate: this.last_air_date,
        name: this.name,
        numberOfEpisodes: this.number_of_episodes,
        numberOfSeasons: this.number_of_seasons,
        originCountry: this.origin_country,
        originalLanguage: this.original_language,
        originalName: this.original_name,
        popularity: this.popularity,
        status: this.status,
        tagline: this.tagline,
        type: this.type,
        nextEpisodeToAir: this.next_episode_to_air);
  }

  @override
  List<Object?> get props => [
        backdrop_path,
        first_air_date,
        homepage,
        id,
        in_production,
        languages,
        last_air_date,
        name,
        next_episode_to_air,
        number_of_episodes,
        number_of_seasons,
        origin_country,
        original_language,
        original_name,
        overview,
        popularity,
        poster_path,
        status,
        tagline,
        type,
        vote_average,
        vote_count,
      ];
}
