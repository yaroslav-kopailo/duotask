class ApiException implements Exception {
  final String message;
  final int statusCode;

  ApiException({required this.statusCode, required this.message});

  @override
  String toString() {
    return 'ApiException{statusCode: $statusCode, message: $message}';
  }
}
