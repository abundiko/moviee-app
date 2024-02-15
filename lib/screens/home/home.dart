import 'package:flutter/material.dart';
import 'package:myapp/data/api_client/fetch_movies.dart';
import 'package:myapp/data/api_client/models/movie.dart';
import 'package:myapp/widgets/widgets.dart';
import 'package:oktoast/oktoast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  String? _errorMessage;
  List<Movie>? _movies;
  bool _isLoadingMore = false;
  int _nextPage = 2;

  void _loadMovies() {
    _errorMessage = null;
    setState(() {});
    FetchMovies.fetchFirstMovies(onResponse: (data, error) {
      if (!error) {
        if (data is List<Movie>) _movies = data;
      } else {
        _errorMessage = "error occurred";
      }
      setState(() {});
    });
  }

  void _loadMoreMovies() {
    if (_movies == null) return;
    _isLoadingMore = true;
    setState(() {});
    FetchMovies.fetchMoreMovies(
        page: _nextPage.toString(),
        onResponse: (data, error) {
          if (!error) {
            if (data is List<Movie>) _movies = [..._movies!, ...data];
            _nextPage++;
            setState(() {});
          } else {
            showToast("loading more...", position: ToastPosition.bottom);
            _loadMoreMovies();
            return;
          }
          _isLoadingMore = false;
          setState(() {});
        });
  }

  void _handleScroll() {
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;

      // Get the current scroll position
      double currentScroll = _scrollController.position.pixels;

      // Define the threshold (50 pixels from the bottom)
      double threshold = maxScroll - 50.0;

      // Check if the current scroll position is within the threshold
      if (currentScroll > threshold && !_isLoadingMore) {
        _loadMoreMovies();
      }
    });
  }

  @override
  void initState() {
    _loadMovies();
    _handleScroll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: AppText.big(
            "Moviee",
            color: Theme.of(context).primaryColor,
          ),
        ),
        Expanded(
            child: ListView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _errorMessage != null
                  ? Column(
                      children: [
                        AppText.medium(
                          _errorMessage!,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                            onPressed: _loadMovies,
                            child: const AppText.small("retry"))
                      ],
                    )
                  : _movies == null
                      ? const SizedBox()
                      : Wrap(
                          runSpacing: 12,
                          spacing: 20,
                          alignment: WrapAlignment.center,
                          children: [
                            ..._movies!
                                .map((e) => MovieCard(
                                      movie: e,
                                    ))
                                .toList(),
                          ],
                        ),
            ),
            if (_isLoadingMore || (_movies == null && _errorMessage == null))
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                    child: LinearProgressIndicator(
                  color: Theme.of(context).primaryColor,
                )),
              )
          ],
        ))
      ],
    );
  }
}
