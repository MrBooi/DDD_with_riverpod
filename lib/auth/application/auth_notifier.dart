import 'package:ddd_riverpod/auth/application/auth_state.dart';
import 'package:ddd_riverpod/auth/infastructure/firebase_auth_facade.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final FirebaseAuthFacade _firebaseAuthFacade;

  AuthNotifier(this._firebaseAuthFacade) : super(const AuthState.initial());

  Future<void> checkAndUpdateUserAuthStatus() async {
    state = (await _firebaseAuthFacade.isSignIn())
        ? const AuthState.authenticated()
        : const AuthState.unauthenticated();
  }

  Future<void> signOut() async {
    final eitherFailureOrUnit = await _firebaseAuthFacade.signOut();
    state = eitherFailureOrUnit.fold(
      (l) => AuthState.failure(l),
      (r) => const AuthState.unauthenticated(),
    );
  }

  Future<void> signWithGoogle() async {
    final eitherFailureOrUnit = await _firebaseAuthFacade.signInWithGoogle();
    state = eitherFailureOrUnit.fold(
      (l) => AuthState.failure(l),
      (r) => const AuthState.authenticated(),
    );
  }
}
