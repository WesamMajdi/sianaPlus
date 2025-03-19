
import 'package:flutter/foundation.dart';

class BaseResponse<T> {
  final dynamic status;
  final dynamic message;  // Can be String or List<String>
  final T? data;

  BaseResponse({
    required this.status,
    required this.message,
    this.data,
  });

  bool get isSuccess => status== 1 ;
  bool get isError =>status!= 1;

  List<String> get messages {
    if (message == null) return [];
    if (message is String) return [message as String];
    if (message is List) return (message as List).map((e) => e.toString()).toList();
    return [];
  }

  factory BaseResponse.fromJson(
      Map<String, dynamic> json,
      T Function(dynamic json) fromJson,
      ) {
    debugPrint(json.toString());

    return BaseResponse<T>(
      status: json['status'] ?? 0,
      message: json['message']?.toString() ?? '',
      data: fromJson(json['data']), // Directly pass the data to fromJson
    );

  }
  Map<String, dynamic> toJson([Map<String, dynamic> Function(T)? toJson]) {
    return {
      'status': status,
      'message': message,
      if (data != null && toJson != null) 'data': toJson(data as T),
    };
  }
}