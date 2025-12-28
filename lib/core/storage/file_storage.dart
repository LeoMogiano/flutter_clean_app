// This file intentionally uses async file I/O methods, which may be slow, but is acceptable for file storage operations in this context.
// ignore_for_file: avoid_slow_async_io
import 'dart:io';

class FileStorage {
  FileStorage(this.baseDir) {
    if (baseDir.existsSync()) return;
    baseDir.createSync(recursive: true);
  }

  final Directory baseDir;

  Future<File> writeBytes(
    String path,
    List<int> bytes,
  ) async {
    final file = File('${baseDir.path}/$path');
    await file.create(recursive: true);
    return file.writeAsBytes(bytes);
  }

  Future<File?> readFile(String path) async {
    final file = File('${baseDir.path}/$path');
    if (!await file.exists()) return null;
    return file;
  }

  Future<bool> exists(String path) async {
    final file = File('${baseDir.path}/$path');
    return file.exists();
  }

  Future<void> delete(String path) async {
    final file = File('${baseDir.path}/$path');
    if (await file.exists()) {
      await file.delete();
    }
  }
}
