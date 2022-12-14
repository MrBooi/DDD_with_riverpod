import 'package:dartz/dartz.dart';
import 'package:ddd_riverpod/features/auth/domain/auth_failure.dart';

abstract class IAuthFacade {
  Future<Either<AuthFailure, Unit>> signInWithGoogle();
  Future<Either<AuthFailure, Unit>> signOut();
  Future<bool> isSignIn();
}
