import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/error/failure.dart';
import 'package:my_app/features/home/domain/entity/book.dart';
import 'package:my_app/features/home/domain/usecases/get_books_usecases.dart';
import 'package:my_app/features/home/domain/usecases/search_books_usecases.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._getBooksUseCase, this._searchBooksUseCase) : super(HomeInitial()) {
    on<LoadBooksEvent>(_onLoadBooks);
    on<SearchBooksEvent>(_onSearchBooks);
  }

  final GetBooksUseCase _getBooksUseCase;
  final SearchBooksUseCase _searchBooksUseCase;

  Future<void> _onLoadBooks(LoadBooksEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final books = await _getBooksUseCase.run();
      emit(HomeLoaded(books));
    } on Failure catch (e) {
      emit(HomeError(e.message!));
    }
  }

  Future<void> _onSearchBooks(SearchBooksEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final books = await _searchBooksUseCase.run(
        SearchBooksParams(
          query: event.query,
          maxResults: event.maxResults,
        ),
      );
      emit(HomeLoaded(books));
    } on Failure catch (e) {
      emit(HomeError(e.message!));
    }
  }
}
