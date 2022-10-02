import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddd_riverpod/profile/domain/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
abstract class UserDTO implements _$UserDTO {
  const UserDTO._();

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);

  factory UserDTO.fromFireStore(DocumentSnapshot doc) =>
      UserDTO.fromJson(doc.data() as Map<String, dynamic>)
          .copyWith(uuid: doc.id);

  const factory UserDTO({
    required String? uuid,
    required String userName,
    required String displayName,
    required String photoUrl,
  }) = _UserDTO;

  factory UserDTO.fromDomain(UserEntity userEntity) {
    return UserDTO(
      uuid: userEntity.id,
      displayName: userEntity.displayName,
      userName: userEntity.userName,
      photoUrl: userEntity.photoUrl,
    );
  }

  factory UserDTO.fromFireStoreUser(User user) {
    return UserDTO(
      uuid: user.uid,
      displayName: user.displayName ?? '',
      userName: '',
      photoUrl: user.photoURL ?? '',
    );
  }

  UserEntity toDomain() {
    return UserEntity(
      id: uuid ?? '',
      displayName: displayName,
      photoUrl: photoUrl,
      userName: userName,
    );
  }
}
