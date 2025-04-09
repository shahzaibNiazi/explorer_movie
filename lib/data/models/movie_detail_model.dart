class MovieDetailData {
  bool? adult;
  String? backdropPath;
  Collection? belongsToCollection;
  int? budget;
  List<Genre>? genres;
  String? homepage;
  int? id;
  String? imdbId;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  List<Company>? productionCompanies;
  List<Country>? productionCountries;
  String? releaseDate;
  int? revenue;
  int? runtime;
  List<Language>? spokenLanguages;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  MovieDetailData({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originCountry,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory MovieDetailData.fromJson(Map<String, dynamic> json) => MovieDetailData(
    adult: json['adult'],
    backdropPath: json['backdrop_path'],
    belongsToCollection: json['belongs_to_collection'] != null
        ? Collection.fromJson(json['belongs_to_collection'])
        : null,
    budget: json['budget'],
    genres: (json['genres'] as List<dynamic>?)
        ?.map((e) => Genre.fromJson(e))
        .toList(),
    homepage: json['homepage'],
    id: json['id'],
    imdbId: json['imdb_id'],
    originCountry: (json['origin_country'] as List<dynamic>?)
        ?.map((e) => e.toString())
        .toList(),
    originalLanguage: json['original_language'],
    originalTitle: json['original_title'],
    overview: json['overview'],
    popularity: (json['popularity'] as num?)?.toDouble(),
    posterPath: json['poster_path'],
    productionCompanies: (json['production_companies'] as List<dynamic>?)
        ?.map((e) => Company.fromJson(e))
        .toList(),
    productionCountries: (json['production_countries'] as List<dynamic>?)
        ?.map((e) => Country.fromJson(e))
        .toList(),
    releaseDate: json['release_date'],
    revenue: json['revenue'],
    runtime: json['runtime'],
    spokenLanguages: (json['spoken_languages'] as List<dynamic>?)
        ?.map((e) => Language.fromJson(e))
        .toList(),
    status: json['status'],
    tagline: json['tagline'],
    title: json['title'],
    video: json['video'],
    voteAverage: (json['vote_average'] as num?)?.toDouble(),
    voteCount: json['vote_count'],
  );

  Map<String, dynamic> toJson() => {
    'adult': adult,
    'backdrop_path': backdropPath,
    'belongs_to_collection': belongsToCollection?.toJson(),
    'budget': budget,
    'genres': genres?.map((e) => e.toJson()).toList(),
    'homepage': homepage,
    'id': id,
    'imdb_id': imdbId,
    'origin_country': originCountry,
    'original_language': originalLanguage,
    'original_title': originalTitle,
    'overview': overview,
    'popularity': popularity,
    'poster_path': posterPath,
    'production_companies':
    productionCompanies?.map((e) => e.toJson()).toList(),
    'production_countries':
    productionCountries?.map((e) => e.toJson()).toList(),
    'release_date': releaseDate,
    'revenue': revenue,
    'runtime': runtime,
    'spoken_languages':
    spokenLanguages?.map((e) => e.toJson()).toList(),
    'status': status,
    'tagline': tagline,
    'title': title,
    'video': video,
    'vote_average': voteAverage,
    'vote_count': voteCount,
  };
}
class Collection {
  int? id;
  String? name;
  String? posterPath;
  String? backdropPath;

  Collection({this.id, this.name, this.posterPath, this.backdropPath});

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
    id: json['id'],
    name: json['name'],
    posterPath: json['poster_path'],
    backdropPath: json['backdrop_path'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'poster_path': posterPath,
    'backdrop_path': backdropPath,
  };
}

class Genre {
  int? id;
  String? name;

  Genre({this.id, this.name});

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
    id: json['id'],
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}

class Company {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  Company({this.id, this.logoPath, this.name, this.originCountry});

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    id: json['id'],
    logoPath: json['logo_path'],
    name: json['name'],
    originCountry: json['origin_country'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'logo_path': logoPath,
    'name': name,
    'origin_country': originCountry,
  };
}

class Country {
  String? iso3166_1;
  String? name;

  Country({this.iso3166_1, this.name});

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    iso3166_1: json['iso_3166_1'],
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    'iso_3166_1': iso3166_1,
    'name': name,
  };
}

class Language {
  String? englishName;
  String? iso639_1;
  String? name;

  Language({this.englishName, this.iso639_1, this.name});

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    englishName: json['english_name'],
    iso639_1: json['iso_639_1'],
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    'english_name': englishName,
    'iso_639_1': iso639_1,
    'name': name,
  };
}
