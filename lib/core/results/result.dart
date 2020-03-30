import '../errors/base_error.dart';

class Result<Error extends BaseError, Data> {
  final Data data;
  final Error error;

  Result({this.data, this.error}) : assert(data != null || error != null);

  bool get hasDataOnly => data != null && error == null;

  bool get hasErrorOnly => data == null && error != null;

  bool get hasDataAndError => data != null && error != null;
}
