abstract class BaseHttpException {}

class DioErrorException extends BaseHttpException {
  final int? code;
  final String message;

  DioErrorException(this.message, {this.code});
  @override
  String toString() {
    return code != null ? "$code: $message" : this.message;
  }
}
