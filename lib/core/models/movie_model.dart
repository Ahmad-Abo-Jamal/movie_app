import 'dart:convert';

import 'package:equatable/equatable.dart';

class MovieDetails extends Equatable {
  final bool adult;
  final int id;
  final String backdrop_path;
  final dynamic belongs_to_collection;
  final int budget;
  final List<Genre> genres;
  final String home_page;
  final String imdb_id;
  final String original_language;
  final String original_title;
  final String overview;
  final num popularity;
  final String poster_path;
  final List<ProductionCompany> production_companies;
  final List<ProductionCountry> production_countries;
  final String release_date;
  final int revenue;
  final int runtime;
  final List<SpokenLanguage> spoken_languages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final num vote_average;
  final int vote_count;
  MovieDetails({
    this.adult,
    this.backdrop_path,
    this.belongs_to_collection,
    this.budget,
    this.genres,
    this.home_page,
    this.imdb_id,
    this.id,
    this.original_language,
    this.original_title,
    this.overview,
    this.popularity,
    this.poster_path,
    this.production_companies,
    this.production_countries,
    this.release_date,
    this.revenue,
    this.runtime,
    this.spoken_languages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.vote_average,
    this.vote_count,
  });

  Map<String, dynamic> toMap() {
    return {
      'adult': adult,
      'id': id,
      'backdrop_path': backdrop_path,
      'belongs_to_collection': belongs_to_collection,
      'budget': budget,
      'genres': genres?.map((x) => x?.toMap())?.toList() ?? [],
      'home_page': home_page,
      'imdb_id': imdb_id,
      'original_language': original_language,
      'original_title': original_title,
      'overview': overview,
      'popularity': popularity,
      'poster_path': poster_path,
      'production_companies':
          production_companies?.map((x) => x?.toMap())?.toList(),
      'production_countries':
          production_countries?.map((x) => x?.toMap())?.toList(),
      'release_date': release_date,
      'revenue': revenue,
      'runtime': runtime,
      'spoken_languages': spoken_languages?.map((x) => x?.toMap())?.toList(),
      'status': status,
      'tagline': tagline,
      'title': title,
      'video': video,
      'vote_average': vote_average,
      'vote_count': vote_count,
    };
  }

  static MovieDetails fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MovieDetails(
      adult: map['adult'],
      id: map['id'],
      backdrop_path: map['backdrop_path'],
      belongs_to_collection: map['belongs_to_collection'],
      budget: map['budget'],
      genres: List<Genre>.from(map['genres']?.map((x) => Genre.fromMap(x))),
      home_page: map['home_page'],
      imdb_id: map['imdb_id'],
      original_language: map['original_language'],
      original_title: map['original_title'],
      overview: map['overview'],
      popularity: map['popularity'],
      poster_path: map['poster_path'],
      production_companies: List<ProductionCompany>.from(
          map['production_companies']
              ?.map((x) => ProductionCompany.fromMap(x))),
      production_countries: List<ProductionCountry>.from(
          map['production_countries']
              ?.map((x) => ProductionCountry.fromMap(x))),
      release_date: map['release_date'],
      revenue: map['revenue'],
      runtime: map['runtime'],
      spoken_languages: List<SpokenLanguage>.from(
          map['spoken_languages']?.map((x) => SpokenLanguage.fromMap(x))),
      status: map['status'],
      tagline: map['tagline'],
      title: map['title'],
      video: map['video'],
      vote_average: map['vote_average'],
      vote_count: map['vote_count'],
    );
  }

  String toJson() => json.encode(toMap());

  static MovieDetails fromJson(String source) => fromMap(json.decode(source));

  @override
  // TODO: implement props
  List<Object> get props => [id];
}

class Genre {
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
}

class SpokenLanguage {
  final String iso_639_1;
  final String name;
  SpokenLanguage({
    this.iso_639_1,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'iso_639_1': iso_639_1,
      'name': name,
    };
  }

  static SpokenLanguage fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SpokenLanguage(
      iso_639_1: map['iso_639_1'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  static SpokenLanguage fromJson(String source) => fromMap(json.decode(source));
}

class ProductionCompany {
  final String name;
  final int id;
  final String logo_path;
  final String origin_country;
  ProductionCompany({
    this.name,
    this.id,
    this.logo_path,
    this.origin_country,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'logo_path': logo_path,
      'origin_country': origin_country,
    };
  }

  static ProductionCompany fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ProductionCompany(
      name: map['name'],
      id: map['id'],
      logo_path: map['logo_path'],
      origin_country: map['origin_country'],
    );
  }

  String toJson() => json.encode(toMap());

  static ProductionCompany fromJson(String source) =>
      fromMap(json.decode(source));
}

class ProductionCountry {
  final String iso_3166_1;
  final String name;
  ProductionCountry({
    this.iso_3166_1,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'iso_3166_1': iso_3166_1,
      'name': name,
    };
  }

  static ProductionCountry fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ProductionCountry(
      iso_3166_1: map['iso_3166_1'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  static ProductionCountry fromJson(String source) =>
      fromMap(json.decode(source));
}
