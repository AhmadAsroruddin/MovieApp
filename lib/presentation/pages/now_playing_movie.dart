import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/presentation/bloc/movie_list_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_list_state.dart';
import 'package:ditonton/presentation/provider/top_rated_series_notifier.dart';
import 'package:ditonton/presentation/widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    print("fired!!!");
    Future.microtask(() {
      context.read<MovieListCubit>().fetchNowPlayingMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MovieListCubit, MovieListState>(
            builder: (context, state) {
          if (state is MovieListLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieListHasDataNowPlaying) {
            return ListView.builder(
              itemCount: state.result.length,
              itemBuilder: (context, index) {
                final series = state.result[index];
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
