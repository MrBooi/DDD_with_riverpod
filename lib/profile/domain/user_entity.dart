import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

// part 'user_model.g.dart';
@freezed
abstract class UserEntity with _$UserEntity {
  const UserEntity._();
  const factory UserEntity({
    required String id,
    required String userName,
    required String displayName,
    required String photoUrl,
  }) = _userEntity;

  factory UserEntity.empty() => const UserEntity(
        displayName: '',
        id: '',
        photoUrl: '',
        userName: '',
      );
}
