import 'package:my_app/core/repositories/book_repository.dart';
import 'package:my_app/features/home/domain/entity/book.dart';

class SearchBooksUseCase {
  SearchBooksUseCase(this.repository);
  final BookRepository repository;

  Future<List<Book>> run(SearchBooksParams params) async {
    final books = await repository.searchBooks(params);

    final validBooks = books.where((b) => b.title.isNotEmpty && b.authors.isNotEmpty).toList();

    return validBooks;
  }
}

class SearchBooksParams {
  SearchBooksParams({
    required this.query, 
    this.maxResults = 10,
  });

  final String query;
  final int? maxResults;
}
