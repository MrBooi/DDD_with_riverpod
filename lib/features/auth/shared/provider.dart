import 'package:ddd_riverpod/features/auth/application/auth_notifier.dart';
import 'package:ddd_riverpod/features/auth/application/auth_state.dart';
import 'package:ddd_riverpod/features/auth/infastructure/firebase_auth_facade.dart';
import 'package:ddd_riverpod/core/shared/providers.dart';
import 'package:ddd_riverpod/features/profile/infastructure/user_facade.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);

final googleAuthProvider = Provider<GoogleSignIn>(
  (ref) => GoogleSignIn(),
);

final userFacadeProvider = Provider<UserFacade>((ref) {
  return UserFacade(
    ref.watch(fireStoreProvider),
    ref.watch(firebaseAuthProvider),
  );
});

final firebaseAuthFacadeProvider = Provider<FirebaseAuthFacade>((ref) {
  return FirebaseAuthFacade(
    ref.watch(firebaseAuthProvider),
    ref.watch(googleAuthProvider),
    ref.watch(userFacadeProvider),
  );
});

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(ref.watch(
    firebaseAuthFacadeProvider,
  )),
);
