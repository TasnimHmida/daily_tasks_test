class ServerException implements Exception {
  final String message;

  ServerException({required this.message});
}
class EmptyCacheException implements Exception{}

class OfflineException implements Exception {}

class TokenException implements Exception {}

class UnknownException implements Exception {
  final String message;

  UnknownException({required this.message});
}
