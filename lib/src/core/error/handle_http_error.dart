import '../error/error_response_model.dart';
import '../error/exception.dart';

class HandleHttpError {
  static void handleHttpError(Map<String, dynamic> json) {
    if (json.containsKey('statusCode')) {
      final errorResponse = ErrorResponseModel.fromJson(json);

      switch (errorResponse.statusCode) {
        case 400:
          final messages =
              errorResponse.messages ?? [errorResponse.message ?? ''];
          throw ValidationException(messages: messages);
        case 401:
          throw UnauthorizedException(
            message: errorResponse.message ?? 'Unauthorized',
          );
        case 500:
        case 502:
        case 503:
        case 504:
          throw ServerException(
            message: errorResponse.message ??
                'Server error (${errorResponse.statusCode})',
          );
        default:
          throw ServerException(
            message: errorResponse.message ?? 'Server error',
          );
      }
    } else {
      if (json['status'] == 'error') {
        if (json['message'] is List) {
          final List<String> messages =
              (json['message'] as List).map((e) => e.toString()).toList();
          throw ValidationException(messages: messages);
        }
        throw ValidationException(
          messages: [json['message'].toString()],
        );
      }
    }
  }
}
