part of 'home_bloc.dart';

abstract class HomeEvent {}

class LoadBooksEvent extends HomeEvent {}

class SearchBooksEvent extends HomeEvent {
  SearchBooksEvent({required this.query, this.maxResults});
  final String query;
  final int? maxResults;
}
