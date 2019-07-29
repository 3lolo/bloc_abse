class FilmModel {
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

  FilmModel(
      this._url, this._name, this._authour, this._rating, this._reviewsCount);
}
