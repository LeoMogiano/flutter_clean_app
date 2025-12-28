import 'package:my_app/core/repositories/book_repository.dart';
import 'package:my_app/data/datasources/remote/book_remote.dart';
import 'package:my_app/data/models/book_dto.dart';
import 'package:my_app/features/home/domain/entity/book.dart';
import 'package:my_app/features/home/domain/usecases/search_books_usecases.dart';

class BookRepositoryImpl implements BookRepository {
  BookRepositoryImpl(this.remoteDataSource);
  final BookRemoteDataSource remoteDataSource;

  @override
  Future<List<Book>> getBooks() async {
    final dtos = await remoteDataSource.getBooks();
    return BookDto.listToDomain(dtos);
  }

  @override
  Future<List<Book>> searchBooks(SearchBooksParams params) async {
    final dtos = await remoteDataSource.searchBooks(params);
    return dtos.map((dto) => dto.toDomain()).toList();
  }
}
