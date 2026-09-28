/// Typed failure that crosses repository boundaries instead of a raw
/// exception. Controllers only ever see a Failure, never a
/// DioException / PlatformException / etc.
class Failure {
  final String message;
  final Object? cause;

  const Failure(this.message, {this.cause});

  factory Failure.network([Object? cause]) =>
      Failure('Could not reach the server. Check your connection.', cause: cause);

  factory Failure.auth([Object? cause]) =>
      Failure('Sign-in failed. Please try again.', cause: cause);

  factory Failure.location([Object? cause]) =>
      Failure('Could not determine your location.', cause: cause);

  factory Failure.unknown([Object? cause]) =>
      Failure('Something went wrong.', cause: cause);

  @override
  String toString() => 'Failure(message: $message)';
}
