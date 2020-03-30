import 'base_error.dart';

class CustomError extends BaseError {
  final String message;

  CustomError({this.message});

  @override
  List<Object> get props => [];
}