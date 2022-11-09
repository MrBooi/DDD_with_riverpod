import 'package:ddd_riverpod/core/shared/providers.dart';

import 'package:ddd_riverpod/features/chat/domain/chat_channel_entity.dart';
import 'package:ddd_riverpod/features/chat/infrastructure/chat_facade.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatFacadeProvider = Provider<ChatFacade>((ref) {
  return ChatFacade(ref.watch(fireStoreProvider));
});

final chatChannelStreamProvider =
    StreamProvider.autoDispose.family<List<ChatChannelEntity>, String>(
  (ref, userId) {
    return ref.watch(chatFacadeProvider).chatChannelEntityStream(
          userId,
        );
  },
);
