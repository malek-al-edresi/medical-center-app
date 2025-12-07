// lib/core/exceptions/database_exception.dart

import 'app_exception.dart';

class DatabaseException extends AppException {
  DatabaseException({
    required String message,
  }) : super(
    message: message,
    prefix: 'Database Error: ',
  );
}

class DatabaseConnectionException extends DatabaseException {
  DatabaseConnectionException({
    required String message,
  }) : super(message: message);
}

class DatabaseQueryException extends DatabaseException {
  DatabaseQueryException({
    required String message,
  }) : super(message: message);
}

class DatabaseInsertException extends DatabaseException {
  DatabaseInsertException({
    required String message,
  }) : super(message: message);
}

class DatabaseUpdateException extends DatabaseException {
  DatabaseUpdateException({
    required String message,
  }) : super(message: message);
}

class DatabaseDeleteException extends DatabaseException {
  DatabaseDeleteException({
    required String message,
  }) : super(message: message);
}