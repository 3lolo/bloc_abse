class MediaModel {
  final int _id;
  int get id => _id;

  final String _type;
  String get type => _type;

  final String _imageUrl;
  String get imageUrl => _imageUrl;

  final String _title;
  String get title => _title;

  final String _titleEn;
  String get titleEn => _titleEn;

  final String _titleJp;
  String get titleJp => _titleJp;

  final String _source;
  String get source => _source;

  final int _papularity;
  int get papularity => _papularity;

  final int _members;
  int get members => _members;

  MediaModel(this._id, this._type, this._imageUrl, this._title, this._titleEn,
      this._titleJp, this._source, this._papularity, this._members);

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> media = json["media"];

    Map<String, dynamic> title = media["title"];
    Map<String, dynamic> images = media["coverImage"];

    return MediaModel(
        media['id'],
        "ANIME",
        images["medium"],
        title["english"] ?? title["userPreferred"],
        json["title_english"],
        json["title_japanese"],
        json["source"],
        json["popularity"],
        json["members"]);
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
