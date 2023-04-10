import 'package:ditonton/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'genre_model.g.dart';

@JsonSerializable()
class GenreModel extends Equatable {
  GenreModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory GenreModel.fromJson(Map<String, dynamic> json) =>
      _$GenreModelFromJson(json);

  Map<String, dynamic> toJson() => _$GenreModelToJson(this);

  Genre toEntity() {
    return Genre(id: this.id, name: this.name);
  }

  @override
  List<Object?> get props => [id, name];
}
