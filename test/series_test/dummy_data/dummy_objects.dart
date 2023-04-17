import 'package:ditonton/data/models/series_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/entities/series_detail.dart';

final testSeries = Series(
    firstAirDate: '9 november 2021',
    backdropPath: './backdropPath',
    genreIds: [1, 2, 3],
    id: 123,
    name: "Film",
    originalLanguage: "Indonesia",
    originalName: "filmss",
    overview: "lorem  asdlkakjsbfjkbfakhdvflavsdfl vdvyfaougdsfuasdlf",
    popularity: 1,
    posterPath: './posterPath',
    voteAverage: 1,
    voteCount: 1,
    jenis: "series");

final testSeriesList = [testSeries];

final testSeriesDetail = SeriesDetail(
    backdropPath: "/suopoADq0k8YZr4dQXcU6pToj6s.jpg",
    firstAirDate: DateTime.parse("2011-04-17"),
    genres: [Genre(id: 10765, name: "Sci-Fi & Fantasy")],
    homepage: "http://www.hbo.com/game-of-thrones",
    id: 1399,
    inProduction: false,
    languages: ["en"],
    lastAirDate: DateTime.parse("2019-05-19"),
    name: "Game of Thrones",
    nextEpisodeToAir: null,
    numberOfEpisodes: 73,
    numberOfSeasons: 8,
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Game Of Thrones",
    overview:
        "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
    popularity: 369.594,
    posterPath: "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg",
    status: "Ended",
    tagline: "Winter Is Coming",
    type: "Scripted",
    voteAverage: 8.3,
    voteCount: 11504);

final testSeriesCache = SeriesTable(
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  title: 'Spider-Man',
);

final testSeriesCacheMap = {
  'id': 557,
  'overview':
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  'posterPath': '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  'title': 'Spider-Man',
  'jenis': 'series'
};

final testSeriesFromCache = Series.watchlist(
    id: 557,
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    name: 'Spider-Man',
    jenis: "series");

final testWatchlistSeries = Series.watchlist(
    id: 1399,
    name: "Game of Thrones",
    posterPath: "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg",
    overview:
        "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
    jenis: "series");

final testSeriesTable = SeriesTable(
    id: 1399,
    title: "Game of Thrones",
    posterPath: "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg",
    overview:
        "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
    jenis: "series");

final testSeriesMap = {
  'id': 1399,
  'title': "Game of Thrones",
  'posterPath': "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg",
  'overview':
      "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
  'jenis': 'series'
};
