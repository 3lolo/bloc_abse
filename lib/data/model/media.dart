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

  final int _favourites;
  int get favourites => _favourites;

  final int _averageScore;
  int get averageScore => _averageScore;

  final String _format;
  String get format => _format;

  final String _startDate;
  String get startDate => _startDate;

  final String _endDate;
  String get endDate => _endDate;

  bool isLikedByMe = false;
  bool isSaved = false;

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
      this._averageScore,
      this._format,
      this._startDate,
      this._endDate);

  factory MediaModel.fromJson(Map<String, dynamic> media) {
    Map<String, dynamic> images = media["coverImage"];
    Map<String, dynamic> startDateMap = media["startDate"];
    Map<String, dynamic> endDateMap = media["endDate"];

    String startDate =
        "${startDateMap["day"] ?? "_"}.${startDateMap["month"] ?? "_"}.${startDateMap["year"] ?? "_"}";
    String endDate =
        "${endDateMap["day"] ?? "_"}.${endDateMap["month"] ?? "_"}.${endDateMap["year"] ?? "_"}";
    endDate = endDate.replaceAll(".", "").replaceAll("_", "").trim().length == 0
        ? "Not finished"
        : endDate;
    Map<String, dynamic> titles = media["title"];
    // List<String> studios = (media["studios"]["nodes"])
    //     .map((it) => it["name"])
    //     .toList()
    //     .cast<String>();
    List<String> genres = (media["genres"] as List).cast<String>();
    List<String> studios;

    return MediaModel(
        media['id'],
        media['type'],
        images['medium'],
        images['extraLarge'],
        titles["english"] ?? titles["userPreferred"],
        media["description"],
        media["season"],
        genres,
        studios,
        media["popularity"],
        media["favourites"],
        media["averageScore"],
        media["format"],
        startDate,
        endDate);
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

  final String _studio;
  String get studio => _studio;

  final String _genres;
  String get genres => _genres;

  final String _description;
  String get description => _description;

  MediaThumbModel(
      this._id,
      this._type,
      this._image,
      this._imageLargeUrl,
      this._title,
      this._favourites,
      this._averageScore,
      this._studio,
      this._genres,
      this._description);

  factory MediaThumbModel.fromJson(Map<String, dynamic> media) {
    // Map<String, dynamic> media = json["media"];

    Map<String, dynamic> title = media["title"];
    Map<String, dynamic> images = media["coverImage"];
    List studios = (media["studios"]["edges"] as List);

    String studio = studios.isEmpty
        ? ""
        : studios.firstWhere((v) => (v["isMain"] == true))["node"]["name"]
            as String;

    String genres = (media["genres"] as List).join(", ");

    return MediaThumbModel(
        media['id'],
        "ANIME",
        images["medium"],
        images["large"],
        title["english"] ?? title["userPreferred"],
        // "" + media["popularity"],
        "",
        media["averageScore"],
        studio,
        genres,
        media["description"]);
  }
}
