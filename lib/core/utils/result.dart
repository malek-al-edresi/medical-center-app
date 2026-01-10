sealed class Result<S, E extends Exception> {
  const Result();

  void fold({
    required void Function(S data) onSuccess,
    required void Function(E error) onFailure,
  }) {
    if (this is Success<S, E>) {
      onSuccess((this as Success<S, E>).data);
    } else if (this is Failure<S, E>) {
      onFailure((this as Failure<S, E>).error);
    }
  }
}

class Success<S, E extends Exception> extends Result<S, E> {
  final S data;
  const Success(this.data);
}

class Failure<S, E extends Exception> extends Result<S, E> {
  final E error;
  const Failure(this.error);
}
