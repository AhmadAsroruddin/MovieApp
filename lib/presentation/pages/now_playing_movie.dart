import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/presentation/provider/top_rated_series_notifier.dart';
import 'package:ditonton/presentation/widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/movie_list_notifier.dart';
import '../provider/series_list_notifier.dart';
import '../widgets/movie_card_list.dart';
import 'home_series_page.dart';

class NowPlayingMoviePage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-movie-page';

  @override
  _NowPlayingMoviePageState createState() => _NowPlayingMoviePageState();
}

class _NowPlayingMoviePageState extends State<NowPlayingMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<MovieListNotifier>(context, listen: false)
            .fetchNowPlayingMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<MovieListNotifier>(builder: (context, data, child) {
          final state = data.nowPlayingState;
          if (state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state == RequestState.Loaded) {
            return ListView.builder(
              itemCount: data.nowPlayingMovies.length,
              itemBuilder: (context, index) {
                final series = data.nowPlayingMovies[index];
                return MovieCard(series);
              },
            );
          } else {
            return Text('Failed');
          }
        }),
      ),
    );
  }
}