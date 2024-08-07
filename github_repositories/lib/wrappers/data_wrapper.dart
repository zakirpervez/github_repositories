enum Status {
  initial, loading, success, failure
}

final class DataWrapper<T> {
  Status status;
  T? data;
  String? errorMessage;

  DataWrapper.initial() : status = Status.initial;
  DataWrapper.loading() : status = Status.loading;
  DataWrapper.success(this.data) : status = Status.success;
  DataWrapper.failure(this.errorMessage) : status = Status.failure;

  @override
  String toString() {
    return 'DataWrapper: $status\nMessage: $errorMessage\nData: $data';
  }
}
