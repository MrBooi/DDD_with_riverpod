import 'package:ddd_riverpod/features/chat/domain/chat_channel_entity.dart';

abstract class IChatFacade {
  Stream<List<ChatChannelEntity>> chatChannelEntityStream(String uuid);
  Future<void> updateChatChannel(
    String channelId,
    Map<String, dynamic> payload,
  );
  Future<ChatChannelEntity?> getChatChannel(String channelId);
}
