// Mocks generated by Mockito 5.4.0 from annotations
// in ditonton/test/series_test/presentation/provider/movie_detail_notifier_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:dartz/dartz.dart' as _i3;
import 'package:ditonton/common/failure.dart' as _i7;
import 'package:ditonton/domain/entities/series.dart' as _i10;
import 'package:ditonton/domain/entities/series_detail.dart' as _i8;
import 'package:ditonton/domain/repositories/movie_repository.dart' as _i4;
import 'package:ditonton/domain/repositories/series_repository.dart' as _i2;
import 'package:ditonton/domain/usecases/get_series_detail.dart' as _i5;
import 'package:ditonton/domain/usecases/get_series_recommendations.dart'
    as _i9;
import 'package:ditonton/domain/usecases/get_watchlist_status.dart' as _i11;
import 'package:ditonton/domain/usecases/removeSeries_watchlist.dart' as _i13;
import 'package:ditonton/domain/usecases/saveSeries_watchlist.dart' as _i12;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeSeriesRepository_0 extends _i1.SmartFake
    implements _i2.SeriesRepository {
  _FakeSeriesRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMovieRepository_2 extends _i1.SmartFake
    implements _i4.MovieRepository {
  _FakeMovieRepository_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetSeriesDetail].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetSeriesDetail extends _i1.Mock implements _i5.GetSeriesDetail {
  MockGetSeriesDetail() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SeriesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeSeriesRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.SeriesRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, _i8.SeriesDetail>> execute(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [id],
        ),
        returnValue:
            _i6.Future<_i3.Either<_i7.Failure, _i8.SeriesDetail>>.value(
                _FakeEither_1<_i7.Failure, _i8.SeriesDetail>(
          this,
          Invocation.method(
            #execute,
            [id],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, _i8.SeriesDetail>>);
}

/// A class which mocks [GetSeriesRecommendations].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetSeriesRecommendations extends _i1.Mock
    implements _i9.GetSeriesRecommendations {
  MockGetSeriesRecommendations() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SeriesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeSeriesRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.SeriesRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, List<_i10.Series>>> execute(dynamic id) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [id],
        ),
        returnValue:
            _i6.Future<_i3.Either<_i7.Failure, List<_i10.Series>>>.value(
                _FakeEither_1<_i7.Failure, List<_i10.Series>>(
          this,
          Invocation.method(
            #execute,
            [id],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, List<_i10.Series>>>);
}

/// A class which mocks [GetWatchListStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListStatus extends _i1.Mock
    implements _i11.GetWatchListStatus {
  MockGetWatchListStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.MovieRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeMovieRepository_2(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i4.MovieRepository);
  @override
  _i6.Future<bool> execute(int? id) => (super.noSuchMethod(
        Invocation.method(
          #execute,
          [id],
        ),
        returnValue: _i6.Future<bool>.value(false),
      ) as _i6.Future<bool>);
}

/// A class which mocks [SaveWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchlist extends _i1.Mock implements _i12.SaveWatchlist {
  MockSaveWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SeriesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeSeriesRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.SeriesRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, String>> execute(
          _i8.SeriesDetail? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [movie],
        ),
        returnValue: _i6.Future<_i3.Either<_i7.Failure, String>>.value(
            _FakeEither_1<_i7.Failure, String>(
          this,
          Invocation.method(
            #execute,
            [movie],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, String>>);
}

/// A class which mocks [RemoveWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchlist extends _i1.Mock implements _i13.RemoveWatchlist {
  MockRemoveWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SeriesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeSeriesRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.SeriesRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, String>> execute(
          _i8.SeriesDetail? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [movie],
        ),
        returnValue: _i6.Future<_i3.Either<_i7.Failure, String>>.value(
            _FakeEither_1<_i7.Failure, String>(
          this,
          Invocation.method(
            #execute,
            [movie],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, String>>);
}
