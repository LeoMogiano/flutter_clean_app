import 'package:dio/dio.dart';
import 'package:my_app/core/storage/file_storage.dart';

class DownloadClient {
  DownloadClient({required this.fileStorage, Dio? dio}) : dio = dio ?? Dio();
  final Dio dio;
  final FileStorage fileStorage;

  Future<void> download(String url, String path, {void Function(int, int)? onProgress}) async {
    final response = await dio.get<List<int>>(
      url,
      options: Options(responseType: ResponseType.bytes),
      onReceiveProgress: onProgress,
    );

    await fileStorage.writeBytes(path, response.data!);
  }
}
