/// Represents a generic failure from an operation or process.
class Failure {
  final int errorCode;

  final String userMessage;

  final String errorMessage;

  const Failure({
    this.errorCode = 400,
    this.userMessage = 'Oops Something went wrong.. We fixing it now',
    this.errorMessage = 'Unexpected error occurred',
  });

  @override
  String toString() {
    return "$runtimeType(errorCode: $errorCode, errorMessage: $errorMessage, userMessage: $userMessage)";
  }
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure({
    super.errorCode,
    super.errorMessage,
    super.userMessage = 'Server Error! Please try your action again',
  });
}

class NotCorrectCredentialsFailure extends Failure {
  const NotCorrectCredentialsFailure({
    super.errorCode,
    super.errorMessage,
    super.userMessage = 'No account with such an email or password',
  });
}
