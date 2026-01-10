class AppException implements Exception {
  final String message;
  final String? code;

  const AppException(this.message, {this.code});

  @override
  String toString() => 'AppException: $message';
}

class ServerException extends AppException {
  const ServerException(super.message, {super.code});
}

class NetworkException extends AppException {
  const NetworkException() : super('No Internet Connection');
}

class DataParsingException extends AppException {
  const DataParsingException(super.message);
}

class NotFoundException extends AppException {
  const NotFoundException(super.message);
}
