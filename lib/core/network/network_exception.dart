/// Custom network exception for handling API errors
class NetworkException implements Exception {
  final String message;
  final int? statusCode;
  final String? url;
  final dynamic originalError;

  const NetworkException({
    required this.message,
    this.statusCode,
    this.url,
    this.originalError,
  });

  /// Create exception from Dio error
  factory NetworkException.fromDioError(dynamic error) {
    if (error is Exception) {
      try {
        final dioError = error;
        return NetworkException(
          message: _getErrorMessage(dioError),
          statusCode: _getStatusCode(dioError),
          url: _getUrl(dioError),
          originalError: dioError,
        );
      } catch (e) {
        return NetworkException(
          message: 'Unexpected error occurred',
          originalError: error,
        );
      }
    }
    return NetworkException(
      message: 'Unexpected error occurred',
      originalError: error,
    );
  }

  /// Create timeout exception
  factory NetworkException.timeout() {
    return const NetworkException(
      message: 'Request timeout. Please check your internet connection.',
    );
  }

  /// Create no internet exception
  factory NetworkException.noInternet() {
    return const NetworkException(
      message: 'No internet connection. Please check your network settings.',
    );
  }

  /// Create server error exception
  factory NetworkException.serverError([int? statusCode]) {
    return NetworkException(
      message: 'Server error occurred. Please try again later.',
      statusCode: statusCode,
    );
  }

  /// Create unauthorized exception
  factory NetworkException.unauthorized() {
    return const NetworkException(
      message: 'Unauthorized access. Please login again.',
      statusCode: 401,
    );
  }

  /// Create forbidden exception
  factory NetworkException.forbidden() {
    return const NetworkException(
      message:
          'Access forbidden. You don\'t have permission to perform this action.',
      statusCode: 403,
    );
  }

  /// Create not found exception
  factory NetworkException.notFound() {
    return const NetworkException(
      message: 'Resource not found.',
      statusCode: 404,
    );
  }

  /// Get user-friendly error message based on status code
  static String _getErrorMessage(dynamic error) {
    // This is a simplified version. In a real app, you might want to
    // handle different Dio error types more specifically
    if (error.toString().contains('SocketException')) {
      return 'No internet connection. Please check your network settings.';
    }
    if (error.toString().contains('TimeoutException')) {
      return 'Request timeout. Please try again.';
    }
    return 'An error occurred. Please try again.';
  }

  /// Extract status code from Dio error
  static int? _getStatusCode(dynamic error) {
    // Implementation depends on your Dio error structure
    // This is a placeholder - adjust based on your actual error handling
    return null;
  }

  /// Extract URL from Dio error
  static String? _getUrl(dynamic error) {
    // Implementation depends on your Dio error structure
    // This is a placeholder - adjust based on your actual error handling
    return null;
  }

  @override
  String toString() {
    return 'NetworkException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
  }
}
