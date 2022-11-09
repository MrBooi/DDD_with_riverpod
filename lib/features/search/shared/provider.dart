import 'package:ddd_riverpod/features/auth/shared/provider.dart';
import 'package:ddd_riverpod/features/profile/domain/user_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userStreamProvider = StreamProvider.autoDispose<List<UserEntity>>((ref) {
  final searchInput = ref.watch(searchInputProvider);
  return ref.watch(userFacadeProvider).findUsersByUsername(searchInput);
});

final searchInputProvider = StateProvider.autoDispose<String>((ref) => '');
