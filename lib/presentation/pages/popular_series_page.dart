import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../bloc/series/series_popular_bloc.dart';
import '../bloc/series/series_popular_state.dart';

class PopularSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-series';

  @override
  _PopularSeriesPageState createState() => _PopularSeriesPageState();
}

class _PopularSeriesPageState extends State<PopularSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<SeriesPopularCubit>().fetchPopularSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<SeriesPopularCubit, SeriesPopularState>(
          builder: (context, data) {
            if (data is SeriesPopularLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data is SeriesPopularHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data.result[index];
                  return SeriesCard(movie);
                },
                itemCount: data.result.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text("error"),
              );
            }
          },
        ),
      ),
    );
  }
}
