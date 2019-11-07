class MediaFavorite {
  int _id;
  get id => _id;
  bool _isFavorite;
  get isFavorite => _isFavorite;
  bool _isFlaged;
  get isFlaged => _isFlaged;
  DateTime _markedAt;
  get markedAt => _markedAt;

  MediaFavorite(this._id, this._isFavorite, this._isFlaged, this._markedAt);

  Map<String, dynamic> toMap() => {
        'id': _id,
        'is_favorite': _isFavorite == true ? 1 : 0,
        'is_flaged': _isFlaged == true ? 1 : 0,
        'at_date_time': _markedAt.toString(),
      };

  static MediaFavorite fromMap(Map<String, dynamic> json) {
    return MediaFavorite(json["id"], 
    json["is_favorite"]==1,
    json["is_flaged"]==1,
    null,
    );
  }
}
