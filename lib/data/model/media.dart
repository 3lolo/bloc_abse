import 'package:bloc_bases/data/model/film_model.dart';

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
    return MediaModel(
        json['mal_id'],
        json['type'],
        json["image_url"],
        json["title"],
        json["title_english"],
        json["title_japanese"],
        json["source"],
        json["popularity"],
        json["members"]);
  }
}
