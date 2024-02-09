class Movie {
  late String imageUrl;
  late String title;
  late String url;
  late MovieDate datetime;

  Movie.fromJson(dynamic json) {
    imageUrl = json['imgUrl'];
    title = json['title'];
    url = json['url'];
    datetime = MovieDate.fromJson(json['datetime']);
  }
}

class MovieDate {
  late String raw;
  late String string;

  MovieDate.fromJson(dynamic json) {
    raw = json['raw'];
    string = json['string'];
  }
}

class MovieDetails {
  late String desc;
  late String? trailer;
  late String imageUrl;
  late String title;
  late String url;
  late String meta;
  late String downloadUrl;
  late MovieDate datetime;

  MovieDetails.fromJson(dynamic json) {
    datetime = MovieDate.fromJson(json['datetime']);
    imageUrl = json['imgUrl'];
    title = json['title'];
    url = json['url'];
    desc = json['desc'];
    meta = json['meta'] ?? '';
    downloadUrl = json['downloadUrl'] ?? '';
    trailer = json['trailer'] ?? '';
  }
}
