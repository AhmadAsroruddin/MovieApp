import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/domain/usecases/search_series.dart';
import 'package:ditonton/presentation/bloc/movies/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movies/movie_list_bloc.dart';
import 'package:ditonton/presentation/bloc/movies/movie_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/movies/movie_topRatedMovies_bloc.dart';
import 'package:ditonton/presentation/bloc/movies/movies_watchList_bloc.dart';
import 'package:ditonton/presentation/bloc/series/search_bloc.dart';
import 'package:ditonton/presentation/bloc/series/series_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/series/series_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/series/series_list_bloc.dart';
import 'package:ditonton/presentation/bloc/series/series_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/series/series_watchList_bloc.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/now_playing_series_page.dart';
import 'package:ditonton/presentation/pages/series_detail_page.dart';
import 'package:ditonton/presentation/pages/home_series_page.dart';
import 'package:ditonton/presentation/pages/popular_series_page.dart';
import 'package:ditonton/presentation/pages/series_search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_series_page.dart';
import 'package:ditonton/presentation/pages/watchlist_sereis_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

import 'presentation/bloc/movies/search_bloc.dart';
import 'presentation/pages/movie_detail_page.dart';
import 'presentation/pages/now_playing_movie.dart';
import 'presentation/pages/popular_movies_page.dart';
import 'presentation/pages/search_page.dart';
import 'presentation/pages/top_rated_movies_page.dart';
void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        
        //bloc movies
        BlocProvider(
          create: (_) => di.locator<SearchCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieListCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieTopRatedCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviesPopularCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviesWatchListCubit>(),
        ),

        //bloc series
        BlocProvider(
          create: (_) => di.locator<SearchSeriesCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesDetailCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesListCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesTopRatedCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesPopularCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesWatchListCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeSeriesPage());
            case HomeSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeSeriesPage());
            case HomeMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularSeriesPage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case TopRatedSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedSeriesPage());
            case SeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => SeriesDetailPage(id: id),
                settings: settings,
              );
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPageSeries.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPageSeries());
            case SearchPageMovie.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPageMovie());
            case NowPlayingSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => NowPlayingSeriesPage());
            case NowPlayingMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => NowPlayingMoviePage());
            case WatchlistSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistSeriesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
