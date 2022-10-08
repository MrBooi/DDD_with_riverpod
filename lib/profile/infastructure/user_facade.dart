import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ddd_riverpod/core/extensions/firebase_x.dart';
import 'package:ddd_riverpod/profile/domain/i_user_facade.dart';
import 'package:ddd_riverpod/profile/domain/user_dto.dart';
import 'package:ddd_riverpod/profile/domain/user_entity.dart';
import 'package:ddd_riverpod/profile/domain/user_failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class UserFacade extends IUserFacade {
  final FirebaseFirestore _fireStore;
  final FirebaseAuth _firebaseAuth;

  UserFacade(
    this._fireStore,
    this._firebaseAuth,
  );

  @override
  Future<Option<bool>> isUserExist(String uuid) async {
    final documentSnapShot = await _fireStore.userCollection.doc(uuid).get();
    return some(documentSnapShot.exists);
  }

  @override
  Future<Either<UserFailure, Unit>> addUser(UserEntity userEntity) async {
    try {
      final userDTO = UserDTO.fromDomain(userEntity);
      await _fireStore.userCollection.doc(userDTO.uuid).set(userDTO.toJson());
      return right(unit);
    } on PlatformException catch (e) {
      if (e.message?.contains("PERMISSION_DENIED") == true) {
        return left(const UserFailure.insufficientPermission());
      } else {
        return left(const UserFailure.unexpected());
      }
    } catch (_) {
      return left(const UserFailure.serverError());
    }
  }

  @override
  Stream<List<UserEntity>> findUsersByUsername(
    String username,
  ) {
    final querySnapShot = _fireStore.userCollection
        .where('username', isEqualTo: username)
        .snapshots();

    return querySnapShot.map((snapshot) {
      final users = <UserEntity>[];

      for (var doc in snapshot.docs) {
        final userDTO = UserDTO.fromFireStore(doc);
        users.add(userDTO.toDomain());
      }
      return users;
    });
  }

  @override
  Future<Either<UserFailure, UserEntity>> getUser() async {
    try {
      final uuid = await _firebaseAuth.currentUser?.uid;
      final userDoc = await _fireStore.userCollection.doc(uuid).get();
      final user = UserDTO.fromFireStore(userDoc).copyWith(
        uuid: uuid,
      );

      return right(user.toDomain());
    } on PlatformException catch (e) {
      if (e.message?.contains('PERMISSION_DENIED') == true) {
        return left(const UserFailure.insufficientPermission());
      } else if (e.message?.contains('NOT_FOUND') == true) {
        return left(const UserFailure.notFound());
      } else {
        return left(const UserFailure.unexpected());
      }
    } catch (_) {
      return left(const UserFailure.serverError());
    }
  }

  @override
  Future<Either<UserFailure, Unit>> updateUser(UserEntity userEntity) async {
    try {
      var userDTO = UserDTO.fromDomain(userEntity);

      await _fireStore.userCollection.doc(userDTO.uuid).update(
            userDTO.toJson(),
          );

      return right(unit);
    } on PlatformException catch (e) {
      if (e.message?.contains('PERMISSION_DENIED') == true) {
        return left(const UserFailure.insufficientPermission());
      } else if (e.message?.contains('NOT_FOUND') == true) {
        return left(const UserFailure.unableToUpdate());
      } else {
        return left(const UserFailure.unexpected());
      }
    } catch (_) {
      return left(const UserFailure.serverError());
    }
  }
}
