abstract class Result<T> {
  final T? data;
  final String? error;

  const Result({this.data, this.error});
}

class Success<T> extends Result<T> {
  const Success(T data) : super(data: data);
}

class Failure<T> extends Result<T> {
  const Failure(String error) : super(error: error);
}
