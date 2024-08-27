import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

Future<void> _downloadFile(String filename) async {
  try {
    //await _requestStoragePermission();

    // Get the directory for the downloads/textbooks
    Directory? directory = await getExternalStorageDirectory();
    if (directory != null) {
      String newPath = '';
      List<String> folders = directory.path.split('/');
      for (int x = 1; x < folders.length; x++) {
        String folder = folders[x];
        if (folder != 'Android') {
          newPath += '/' + folder;
        } else {
          break;
        }
      }
      newPath = newPath + '/Downloads/Textbooks';
      directory = Directory(newPath);

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      // File download path
      String filePath = '${directory.path}/$filename';

      // Dio instance for downloading
      Dio dio = Dio();

      // Download the file
      await dio.download(
        'http://192.168.1.5:3000/download/$filename', // Replace with your server's URL
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print('Received: ${(received / total * 100).toStringAsFixed(0)}%');
          }
        },
      );

      print('File downloaded to $filePath');
    }
  } catch (e) {
    print('Error downloading file: $e');
  }
}
