import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/data/api_client/fetch_movies.dart';
import 'package:myapp/data/api_client/models/movie.dart';
import 'package:myapp/screens/movie/youtube_view.dart';
import 'package:myapp/state/download.dart';
import 'package:myapp/utils/utils.dart';
import 'package:myapp/widgets/widgets.dart';

class MovieScreen extends ConsumerStatefulWidget {
  const MovieScreen({super.key, required this.movie});
  final Movie movie;

  @override
  ConsumerState<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends ConsumerState<MovieScreen> {
  MovieDetails? _movie;

  void _loadMovie() {
    FetchMovies.fetchSingleMovie(
        url: widget.movie.url,
        onResponse: (data, error) {
          if (error) {
          } else {
            _movie = data as MovieDetails;
          }
          if (mounted) {
            setState(() {});
          }
        });
  }

  void _updateDownloadState(String status, double progress) {
    final prevState = ref.read(DownloadState.que);
    ref.read(DownloadState.que.notifier).state = {
      ...prevState,
      widget.movie.title: {'status': status, 'progress': progress}
    };
  }

  void _startDownload() {
    _updateDownloadState('starting', 0);
    FileDownloader.downloadFile(
        url: _movie!.downloadUrl,
        headers: {
          // "Content-Type": "application/x-www-form-urlencoded",
          'Cookie': 'filehosting=s0d8m247bcd1ejfoi2n4t31ggn;'
        },
        name: _movie!.title, //(optional)
        onProgress: (String? fileName, double progress) {
          print('FILE fileName HAS PROGRESS $progress');
          _updateDownloadState('downloading', progress);
        },
        onDownloadCompleted: (String path) {
          print('FILE DOWNLOADED TO PATH: $path');
          _updateDownloadState('done', 100);
        },
        onDownloadError: (String error) {
          _updateDownloadState('failed', 0);
        });
  }

  @override
  void initState() {
    _loadMovie();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final m = widget.movie;
    final isInDownloads =
        ref.watch(DownloadState.que).containsKey(widget.movie.title);
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: .3,
            child: Hero(
              tag: m.imageUrl,
              child: SizedBox(
                height: 400,
                child: CachedNetworkImage(
                  imageUrl: m.imageUrl,
                  height: double.maxFinite,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 280,
            padding: const EdgeInsets.only(top: 50),
            child: CachedNetworkImage(
                imageUrl: m.imageUrl, height: 200, fit: BoxFit.contain),
          ),
          ListView(physics: const BouncingScrollPhysics(), children: [
            const SizedBox(height: 280),
            Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                          tag: m.title,
                          child: Material(
                              type: MaterialType.transparency,
                              child: AppText.big(m.title))),
                      const SizedBox(height: 20),
                      AppText.small(
                        m.datetime.string,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(height: 20),
                      if (_movie != null) ...[
                        YoutubeView(url: _movie!.trailer ?? ''),
                        const SizedBox(height: 20),
                        AppText.small(
                          _movie!.desc,
                          size: size * 2.6,
                          color: Theme.of(context).shadowColor.withOpacity(.8),
                        ),
                        const SizedBox(height: 20),
                        AppText.small(
                          _movie!.meta.replaceAll('\n', '\n\n'),
                          size: size * 2.6,
                          color: Theme.of(context).shadowColor.withOpacity(.8),
                        ),
                        const SizedBox(height: 20),
                        AppButton.primary(
                          onPressed: () => _startDownload(),
                          child: isInDownloads
                              ? "${ref.watch(DownloadState.que)[widget.movie.title]['status']} ${ref.watch(DownloadState.que)[widget.movie.title]['progress']}%"
                              : "Download Movie",
                        )
                      ],
                    ]))
          ]),
          Positioned(
              top: 10 + MediaQuery.of(context).padding.top,
              left: 10,
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Theme.of(context).shadowColor,
                  ),
                  onPressed: () => back(context)))
        ],
      ),
    );
  }
}
