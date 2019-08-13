class MediaModel {
  final int _id;
  int get id => _id;

  final String _type;
  String get type => _type;

  final String _image;
  String get image => _image;

  final String _imageLargeUrl;
  String get imageLargeUrl => _imageLargeUrl;

  final String _title;
  String get title => _title;

  final String _description;
  String get description => _description;

  final String _season;
  String get season => _season;

  final List<String> _genres;
  List<String> get genres => _genres;

  final List<String> _studios;
  List<String> get studios => _studios;

  final int _popularity;
  int get popularity => _popularity;

  final String _favourites;
  String get favourites => _favourites;

  final int _averageScore;
  int get averageScore => _averageScore;

  MediaModel(
      this._id,
      this._type,
      this._image,
      this._imageLargeUrl,
      this._title,
      this._description,
      this._season,
      this._genres,
      this._studios,
      this._popularity,
      this._favourites,
      this._averageScore);

  factory MediaModel.fromJson(Map<String, dynamic> media) {
    Map<String, dynamic> images = media["coverImage"];
    // Map<String, dynamic> startDate = media["startDate"];
    // Map<String, dynamic> endDate = media["endDate"];
    Map<String, dynamic> titles = media["title"];
    List<String> studios = (media["studios"]["nodes"]).map((it)=>it["name"]).toList();
    // List<String> studios = List();
    studiosMap.forEach((k, v) => studios.add(v));
    List<String> genres =
        (media["genres"] as List).map((it) => it.toString()).toList();

    return MediaModel(
        media['id'],
        media['type'],
        images['medium'],
        images['extraLarge'],
        titles["english"] ?? media["userPreffered"],
        media["description"],
        media["season"],
        genres,
        studios,
        media["popularity"],
        media["favorites"],
        media["averageScore"]);
  }
}

class MediaThumbModel {
  final int _id;
  int get id => _id;

  final String _type;
  String get type => _type;

  final String _image;
  String get image => _image;

  final String _imageLargeUrl;
  String get imageLargeUrl => _imageLargeUrl;

  final String _title;
  String get title => _title;

  final String _favourites;
  String get favourites => _favourites;

  final int _averageScore;
  int get averageScore => _averageScore;

  MediaThumbModel(this._id, this._type, this._image, this._imageLargeUrl,
      this._title, this._favourites, this._averageScore);

  factory MediaThumbModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> media = json["media"];

    Map<String, dynamic> title = media["title"];
    Map<String, dynamic> images = media["coverImage"];

    return MediaThumbModel(
        media['id'],
        "ANIME",
        images["medium"],
        images["extraLarge"],
        title["english"] ?? title["userPreferred"],
        json["favourites"],
        json["averageScore"]);
  }
}
