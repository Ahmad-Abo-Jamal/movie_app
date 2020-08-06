import 'dart:convert';

import 'package:equatable/equatable.dart';

class TvDetails extends Equatable {
  final int id;
  final List<int> created_by;
  final List<int> episode_run_time;
  final String first_air_date;
  final String backdrop_path;
  final dynamic belongs_to_collection;
  final String name;
  final int number_of_episodes;
  final int number_of_seasons;
  final List<Season> seasons;
  final String type;
  final bool in_production;
  final String last_air_date;
  final int budget;
  final List<Genre> genres;
  final String home_page;
  final String imdb_id;
  final String original_language;
  final String original_title;
  final String overview;
  final num popularity;
  final String poster_path;
  final String status;
  final num vote_average;
  final int vote_count;
  TvDetails({
    this.id,
    this.created_by,
    this.episode_run_time,
    this.first_air_date,
    this.backdrop_path,
    this.belongs_to_collection,
    this.name,
    this.number_of_episodes,
    this.number_of_seasons,
    this.seasons,
    this.type,
    this.in_production,
    this.last_air_date,
    this.budget,
    this.genres,
    this.home_page,
    this.imdb_id,
    this.original_language,
    this.original_title,
    this.overview,
    this.popularity,
    this.poster_path,
    this.status,
    this.vote_average,
    this.vote_count,
  });

  @override
  // TODO: implement props
  List<Object> get props {
    return [id];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_by': created_by,
      'episode_run_time': episode_run_time,
      'first_air_date': first_air_date,
      'backdrop_path': backdrop_path,
      'belongs_to_collection': belongs_to_collection,
      'name': name,
      'number_of_episodes': number_of_episodes,
      'number_of_seasons': number_of_seasons,
      'seasons': seasons?.map((x) => x?.toMap())?.toList(),
      'type': type,
      'in_production': in_production,
      'last_air_date': last_air_date,
      'budget': budget,
      'genres': genres?.map((x) => x?.toMap())?.toList(),
      'home_page': home_page,
      'imdb_id': imdb_id,
      'original_language': original_language,
      'original_title': original_title,
      'overview': overview,
      'popularity': popularity,
      'poster_path': poster_path,
      'status': status,
      'vote_average': vote_average,
      'vote_count': vote_count,
    };
  }

  factory TvDetails.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TvDetails(
      id: map['id'],
      created_by: List<int>.from(map['created_by']),
      episode_run_time: List<int>.from(map['episode_run_time']),
      first_air_date: map['first_air_date'],
      backdrop_path: map['backdrop_path'],
      belongs_to_collection: map['belongs_to_collection'],
      name: map['name'],
      number_of_episodes: map['number_of_episodes'],
      number_of_seasons: map['number_of_seasons'],
      seasons: List<Season>.from(map['seasons']?.map((x) => Season.fromMap(x))),
      type: map['type'],
      in_production: map['in_production'],
      last_air_date: map['last_air_date'],
      budget: map['budget'],
      genres: List<Genre>.from(map['genres']?.map((x) => Genre.fromMap(x))),
      home_page: map['home_page'],
      imdb_id: map['imdb_id'],
      original_language: map['original_language'],
      original_title: map['original_title'],
      overview: map['overview'],
      popularity: map['popularity'],
      poster_path: map['poster_path'],
      status: map['status'],
      vote_average: map['vote_average'],
      vote_count: map['vote_count'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TvDetails.fromJson(String source) =>
      TvDetails.fromMap(json.decode(source));

  TvDetails copyWith({
    int id,
    List<int> created_by,
    List<int> episode_run_time,
    String first_air_date,
    String backdrop_path,
    dynamic belongs_to_collection,
    String name,
    int number_of_episodes,
    int number_of_seasons,
    List<Season> seasons,
    String type,
    bool in_production,
    String last_air_date,
    int budget,
    List<Genre> genres,
    String home_page,
    String imdb_id,
    String original_language,
    String original_title,
    String overview,
    num popularity,
    String poster_path,
    String status,
    num vote_average,
    int vote_count,
  }) {
    return TvDetails(
      id: id ?? this.id,
      created_by: created_by ?? this.created_by,
      episode_run_time: episode_run_time ?? this.episode_run_time,
      first_air_date: first_air_date ?? this.first_air_date,
      backdrop_path: backdrop_path ?? this.backdrop_path,
      belongs_to_collection:
          belongs_to_collection ?? this.belongs_to_collection,
      name: name ?? this.name,
      number_of_episodes: number_of_episodes ?? this.number_of_episodes,
      number_of_seasons: number_of_seasons ?? this.number_of_seasons,
      seasons: seasons ?? this.seasons,
      type: type ?? this.type,
      in_production: in_production ?? this.in_production,
      last_air_date: last_air_date ?? this.last_air_date,
      budget: budget ?? this.budget,
      genres: genres ?? this.genres,
      home_page: home_page ?? this.home_page,
      imdb_id: imdb_id ?? this.imdb_id,
      original_language: original_language ?? this.original_language,
      original_title: original_title ?? this.original_title,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      poster_path: poster_path ?? this.poster_path,
      status: status ?? this.status,
      vote_average: vote_average ?? this.vote_average,
      vote_count: vote_count ?? this.vote_count,
    );
  }

  @override
  bool get stringify => true;
}

class Genre extends Equatable {
  final int id;
  final String name;
  Genre({
    this.id,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  static Genre fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Genre(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  static Genre fromJson(String source) => fromMap(json.decode(source));

  @override
  // TODO: implement props
  List<Object> get props => [id];
}

class Season extends Equatable {
  final String air_date;
  final int episode_count;
  final int id;

  final String poster_path;
  final int season_number;
  Season({
    this.air_date,
    this.episode_count,
    this.id,
    this.poster_path,
    this.season_number,
  });

  Season copyWith({
    String air_date,
    int episode_count,
    int id,
    String poster_path,
    int season_number,
  }) {
    return Season(
      air_date: air_date ?? this.air_date,
      episode_count: episode_count ?? this.episode_count,
      id: id ?? this.id,
      poster_path: poster_path ?? this.poster_path,
      season_number: season_number ?? this.season_number,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'air_date': air_date,
      'episode_count': episode_count,
      'id': id,
      'poster_path': poster_path,
      'season_number': season_number,
    };
  }

  factory Season.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Season(
      air_date: map['air_date'],
      episode_count: map['episode_count'],
      id: map['id'],
      poster_path: map['poster_path'],
      season_number: map['season_number'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Season.fromJson(String source) => Season.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Season(air_date: $air_date, episode_count: $episode_count, id: $id, poster_path: $poster_path, season_number: $season_number)';
  }

  @override
  List<Object> get props {
    return [
      id,
    ];
  }
}
