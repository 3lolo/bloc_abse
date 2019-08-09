class ApiResponse<T> {
  String _requestHash;
  String get requestHash => _requestHash;
  bool _requestCached;
  bool get requestCached => _requestCached;
  int _requestCacheExpiry;
  int get requestCacheExpiry => _requestCacheExpiry;
  T _data;
  T get data => _data;

  ApiResponse(this._requestHash, this._requestCached, this._requestCacheExpiry,
      this._data);

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic) func) {
    return ApiResponse(json['request_hash'], json['request_cached'],
        json['request_cache_expiry'], func(json['top']));
  }
}
