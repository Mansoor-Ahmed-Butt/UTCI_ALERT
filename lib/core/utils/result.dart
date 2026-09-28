import '../errors/failure.dart';

/// success/failure wrapper. Repositories and usecases return this
/// instead of throwing, so controllers never need try/catch.
sealed class Result<T> {
  const Result();

  factory Result.success(T data) = Success<T>;
  factory Result.failure(Failure failure) = ResultFailure<T>;

  R when<R>({
    required R Function(T data) success,
    required R Function(Failure failure) failure,
  }) {
    final self = this;
    if (self is Success<T>) return success(self.data);
    if (self is ResultFailure<T>) return failure(self.failure);
    throw StateError('Unreachable');
  }

  bool get isSuccess => this is Success<T>;
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class ResultFailure<T> extends Result<T> {
  final Failure failure;
  const ResultFailure(this.failure);
}
