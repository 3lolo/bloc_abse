class FilmModel {
  final int _id;
  int get id => _id;
  final String _url;
  String get url => _url;
  final String _name;
  String get name => _name;
  final String _authour;
  String get athour => _authour;
  final double _rating;
  double get rating => _rating;
  final int _reviewsCount;
  int get reviewsCount => _reviewsCount;
  final String _description;
  String get description => _description;

  FilmModel(this._id, this._url, this._name, this._authour, this._rating,
      this._reviewsCount, this._description);

  factory FilmModel.fromJson(Map<String, dynamic> json) {
    return FilmModel(
        json['mal_id'], json['image_url'], json['title'], "", 0, 0, "");
  }
}
