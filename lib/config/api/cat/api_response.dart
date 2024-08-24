class ApiResponse<T> {
  int code;
  String message;
  T? data;

  ApiResponse({
    this.code = 0,
    this.message = "",
    this.data,
  });

  factory ApiResponse.handler(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJson,
  ) =>
      ApiResponse(
        code: json["code"],
        message: json["message"],
        data: json["code"] != 0 ? null : fromJson(json["data"]),
      );

  bool isError() => code != 0;

  String getError() => message;

  T? getSucces() => data;
}
