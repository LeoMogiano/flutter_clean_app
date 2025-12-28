import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:my_app/bootstrap/app_config.dart';
import 'package:my_app/core/network/api_client.dart';
import 'package:my_app/core/network/dowload_client.dart';
import 'package:my_app/core/repositories/book_repository.dart';
import 'package:my_app/core/repositories/book_repository_impl.dart';
import 'package:my_app/core/services/connectivity/connectivity_service.dart';
import 'package:my_app/core/services/isolate_service.dart';
import 'package:my_app/core/services/logger_service.dart';
import 'package:my_app/core/storage/file_storage.dart';
import 'package:my_app/core/storage/prefs_storage.dart';
import 'package:my_app/core/storage/secure_storage.dart';
import 'package:my_app/data/datasources/remote/book_remote.dart';
import 'package:my_app/features/home/domain/usecases/get_books_usecases.dart';
import 'package:my_app/features/home/domain/usecases/search_books_usecases.dart';
import 'package:my_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:path_provider/path_provider.dart';

final GetIt sl = GetIt.instance;

Future<void> injection() async {
  final tempDir = await getApplicationCacheDirectory();
  final baseDir = Directory('${tempDir.path}/my_app_files');

  sl
    // 1️⃣ Core services
    ..registerLazySingleton(LoggerService.new)
    ..registerLazySingleton(IsolateService.new)
    ..registerLazySingleton(ConnectivityService.new)

    // 2️⃣ Storage
    ..registerLazySingleton(PrefsStorage.new)
    ..registerLazySingleton(SecureStorage.new)
    ..registerLazySingleton(() => FileStorage(baseDir))

    // 3️⃣ Network
    ..registerLazySingleton<ApiClient>(
      () => ApiClient(baseUrl: AppConfig.apiBaseUrl),
      instanceName: 'books',
    )
    ..registerLazySingleton<DownloadClient>(
      () => DownloadClient(
        fileStorage: sl<FileStorage>()
      ),
    )
    // 4️⃣ Data sources, usecases and repositories
    ..registerLazySingleton<BookRemoteDataSource>(
      () => BookRemoteDataSource(sl<ApiClient>(instanceName: 'books'))
    )

    ..registerFactory(() => GetBooksUseCase(sl()))
    ..registerFactory(() => SearchBooksUseCase(sl()))
    
    ..registerLazySingleton<BookRepository>(
      () => BookRepositoryImpl(sl())
    )

    
    //6️⃣ Blocs
    ..registerFactory(() => HomeBloc(
      sl<GetBooksUseCase>(),
      sl<SearchBooksUseCase>(),
    ));
}
