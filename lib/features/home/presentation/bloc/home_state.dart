part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  HomeLoaded(this.books);
  final List<Book> books;
}

class HomeError extends HomeState {
  HomeError(this.message);
  final String message;
}
