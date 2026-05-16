import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class MyBlocObserver extends BlocObserver {
  MyBlocObserver(this._logger);

  final Logger _logger;

  @override
  void onCreate(BlocBase<Object?> bloc) {
    super.onCreate(bloc);
    if (kDebugMode) {
      _logger.i('onCreate -- ${bloc.runtimeType}');
    }
  }

  @override
  void onChange(
    BlocBase<Object?> bloc,
    Change<Object?> change,
  ) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      _logger.i('onChange -- ${bloc.runtimeType}, $change');
    }
  }

  @override
  void onError(
    BlocBase<Object?> bloc,
    Object error,
    StackTrace stackTrace,
  ) {
    if (kDebugMode) {
      _logger.e(
        'onError -- ${bloc.runtimeType}',
        error: error,
        stackTrace: stackTrace,
      );
    }
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase<Object?> bloc) {
    super.onClose(bloc);
    if (kDebugMode) {
      _logger.i('onClose -- ${bloc.runtimeType}');
    }
  }
}
