// lib/core/exceptions/app_exception.dart

class AppException implements Exception {
  final String message;
  final String prefix;
  final String url;

  AppException({
    required this.message,
    required this.prefix,
    this.url = '',
  });

  @override
  String toString() {
    return "$prefix$message";
  }
}