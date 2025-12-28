import 'package:my_app/core/repositories/book_repository.dart';
import 'package:my_app/features/home/domain/entity/book.dart';

class GetBooksUseCase {
  GetBooksUseCase(this.repository);
  final BookRepository repository;

  Future<List<Book>> run() async {
    final books = await repository.getBooks();

    final validBooks = books.where((b) => b.title.isNotEmpty && b.authors.isNotEmpty).toList();

    return validBooks;
  }
}
