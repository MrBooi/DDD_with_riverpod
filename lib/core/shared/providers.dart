import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddd_riverpod/features/auth/shared/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final hiveProvider = Provider(((ref) => Hive.initFlutter()));

final fireStoreProvider = Provider<FirebaseFirestore>(
  (ref) => FirebaseFirestore.instance,
);

final initializationProvider = FutureProvider<void>(
  ((ref) async {
    final authNotifier = ref.read(authNotifierProvider.notifier);
    await authNotifier.checkAndUpdateUserAuthStatus();
  }),
);
