import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_failure.freezed.dart';

@freezed
abstract class UserFailure with _$UserFailure {
  const factory UserFailure.serverError() = _ServerError;
  const factory UserFailure.unexpected() = _UnexpectedUserFailure;
  const factory UserFailure.unableToUpdate() = _UnableToUpdate;
  const factory UserFailure.notFound() = _notFound;
  const factory UserFailure.insufficientPermission() =
      _InsufficientMatchPermission;
}
