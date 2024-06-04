import 'dart:developer';

import 'package:duotask/core/error/exceptions.dart';
import 'package:duotask/core/error/failures.dart';
import 'package:flutter/foundation.dart';

/// Handles global errors and maps them to failure objects.
Failure handleError(Object error, {Failure? defaultFailure}) {
  log('handleError: $error');

  final failure = _handleError(error, defaultFailure);

  return failure;
}

Failure _handleError(Object error, [Failure? defaultFailure]) {
  if (error is ApiException) {
    if (error.statusCode == 500) {
      if (error.message.contains("Internal Server Error")) {
        return ServerFailure(
          errorCode: error.statusCode,
          errorMessage: error.message,
        );
      }
    } //
    else if (error.statusCode == 503) {
      if (error.message.contains("Service Unavailable")) {
        return ServerFailure(
          errorCode: error.statusCode,
          errorMessage: error.message,
        );
      }
    } //
    else if (error.statusCode == 401) {
      if (error.message.contains("No account with such an email or password")) {
        return NotCorrectCredentialsFailure(
          errorCode: error.statusCode,
          errorMessage: error.message,
        );
      }
    }
  }

  if (defaultFailure != null) {
    log('defaultFailure: $defaultFailure');
    return defaultFailure;
  }

  log('Undefined error:', error: error);

  if (kReleaseMode) {
    return const Failure();
  } //
  else {
    throw error;
  }
}
