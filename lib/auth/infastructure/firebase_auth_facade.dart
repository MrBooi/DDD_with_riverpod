import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddd_riverpod/auth/domain/auth_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ddd_riverpod/auth/domain/i_auth_facade.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthFacade implements IAuthFacade {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _firebaseFirestore;
  FirebaseAuthFacade(
    this._firebaseAuth,
    this._googleSignIn,
    this._firebaseFirestore,
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
