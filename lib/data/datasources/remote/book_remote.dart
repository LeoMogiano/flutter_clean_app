import 'package:dio/dio.dart';
import 'package:my_app/core/error/failure.dart';
import 'package:my_app/core/network/api_client.dart';
import 'package:my_app/data/models/book_dto.dart';
import 'package:my_app/features/home/domain/usecases/search_books_usecases.dart';

class BookRemoteDataSource {
  BookRemoteDataSource(this._client);
  final ApiClient _client;

  Future<List<BookDto>> getBooks() async {
    try {
      final response = await _client.get<Map<String, dynamic>>(
        '/books',
        options: Options(headers: {'Authorization': 'Bearer YOUR_API_KEY'}),
      );
      return BookDto.listFromJson(response.data!);
    } on DioException catch (e) {
      throw mapDioErrorToFailure(e);
    }
  }

  Future<List<BookDto>> searchBooks(SearchBooksParams params) async {
    try {
      final response = await _client.post<Map<String, dynamic>>(
        '/search',
        data: {
          'query': params.query,
          'maxResults': params.maxResults,
        },
      );
      return BookDto.listFromJson(response.data!);
    } on DioException catch (e) {
      throw mapDioErrorToFailure(e);
    }
  }
}
