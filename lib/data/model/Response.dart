class ApiResponse<T> {
  T _data;
  T get data => _data;

  ApiResponse(this._data);

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, String key, T Function(dynamic) func) {
    return ApiResponse(func(json[key]));
  }
}
