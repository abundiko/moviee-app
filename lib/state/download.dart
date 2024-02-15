import 'package:flutter_riverpod/flutter_riverpod.dart';

class DownloadState {
  static final que = StateProvider<Map<String, dynamic>>((ref) => {});
  
  // static FileDownloa
  // FileDownloader.downloadFile(
  //   url: "YOUR DOWNLOAD URL",
  //   name: "THE FILE NAME AFTER DOWNLOADING",//(optional)
  //   onProgress: (String fileName, double progress) {
  //     print('FILE fileName HAS PROGRESS $progress');
  //   },
  //   onDownloadCompleted: (String path) {
  //     print('FILE DOWNLOADED TO PATH: $path');
  //   },
  //   onDownloadError: (String error) {
  //     print('DOWNLOAD ERROR: $error');
  //   });
}
