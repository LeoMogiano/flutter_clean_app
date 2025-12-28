import 'package:my_app/features/home/domain/entity/book.dart';
import 'package:my_app/features/home/domain/usecases/search_books_usecases.dart';

abstract class BookRepository {
  Future<List<Book>> getBooks();
  Future<List<Book>> searchBooks(SearchBooksParams params);
}
