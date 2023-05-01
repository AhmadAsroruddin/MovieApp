import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/presentation/widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../bloc/movies/movie_list_bloc.dart';
import '../bloc/series/series_list_bloc.dart';
import '../bloc/series/series_list_state.dart';
import 'home_series_page.dart';

class NowPlayingSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-series-page';

  @override
  _NowPlayingSeriesPageState createState() => _NowPlayingSeriesPageState();
}

class _NowPlayingSeriesPageState extends State<NowPlayingSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<SeriesListCubit>().fetchNowPlayingSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<SeriesListCubit, SeriesListState>(
            builder: (context, state) {
          if (state is SeriesListLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SeriesListHasData) {
            return ListView.builder(
              itemCount: state.result.length,
              itemBuilder: (context, index) {
                final series = state.result[index];
                return SeriesCard(series);
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
