import 'dart:developer' as dev;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/home/presentation/bloc/home_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    if (bloc is HomeBloc) {
      dev.log('🔄 Transition en [1m${bloc.runtimeType}[0m', name: 'BLOC');
      dev.log('De: ${transition.currentState}', name: 'BLOC');
      dev.log('A: ${transition.nextState}', name: 'BLOC');
      dev.log('Evento: ${transition.event}', name: 'BLOC');
    }
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    if (bloc is HomeBloc) {
      dev.log(
        '❌ Error en [1m${bloc.runtimeType}[0m',
        name: 'BLOC',
        level: 1000,
        error: error,
        stackTrace: stackTrace,
      );
      dev.log('Mensaje: $error', name: 'BLOC', level: 1000);
      dev.log('StackTrace: $stackTrace', name: 'BLOC', level: 1000);
    }
    super.onError(bloc, error, stackTrace);
  }
}
