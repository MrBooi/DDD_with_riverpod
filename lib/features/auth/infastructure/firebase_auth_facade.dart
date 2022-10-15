import 'package:ddd_riverpod/features/auth/domain/auth_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ddd_riverpod/features/auth/domain/i_auth_facade.dart';
import 'package:ddd_riverpod/features/profile/domain/user_dto.dart';
import 'package:ddd_riverpod/features/profile/infastructure/user_facade.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthFacade implements IAuthFacade {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final UserFacade _userFacade;
  FirebaseAuthFacade(
    this._firebaseAuth,
    this._googleSignIn,
    this._userFacade,
  );

  @override
  Future<bool> isSignIn() async {
    return _firebaseAuth.currentUser != null ? true : false;
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return left(const AuthFailure.cancelledByUser());
      }

      final googleAuthentication = await googleUser.authentication;

      final authCredential = GoogleAuthProvider.credential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken,
      );

      await _firebaseAuth.signInWithCredential(authCredential);

      final uuid = _firebaseAuth.currentUser!.uid;
      final userExist = await _userFacade.isUserExist(uuid);

      userExist.fold(
        () {},
        (exist) {
          if (exist) {
            final user = UserDTO.fromFireStoreUser(
              _firebaseAuth.currentUser!,
            );
            _userFacade.addUser(user.toDomain());
            // TODO Hanlde error
          }
        },
      );

      return right(unit);
    } on FirebaseAuthException catch (_) {
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
      return right(unit);
    } catch (_) {
      return left(const AuthFailure.serverError());
    }
  }
}
