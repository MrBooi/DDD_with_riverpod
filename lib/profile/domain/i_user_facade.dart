import 'package:dartz/dartz.dart';
import 'package:ddd_riverpod/profile/domain/user_failure.dart';
import 'package:ddd_riverpod/profile/domain/user_entity.dart';

abstract class IUserFacade {
  Future<Option<bool>> isUserExist(String uid);
  Future<Either<UserFailure, Unit>> addUser(UserEntity userEntity);
  Future<Either<UserFailure, Unit>> updateUser(UserEntity userEntity);
  Future<Either<UserFailure, UserEntity>> getUser();
  Stream<Either<UserFailure, List<UserEntity>>> findUsersByUsername(
    String username,
  );
}
