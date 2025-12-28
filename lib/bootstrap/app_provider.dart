import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/bootstrap/injection.dart';
import 'package:my_app/features/home/presentation/bloc/home_bloc.dart';

class StateProviders extends StatelessWidget {
  const StateProviders({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (_) => sl<HomeBloc>()..add(LoadBooksEvent()),
        ),
      ],
      child: child,
    );
  }
}
