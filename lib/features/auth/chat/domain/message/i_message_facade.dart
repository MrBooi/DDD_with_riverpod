import 'package:ddd_riverpod/features/chat/domain/message/message_entity.dart';

abstract class IMessageFacade {
  Stream<List<MessageEntity>> messageStream(String channelId);
  Future<void> addMessage(MessageEntity message);
  Future<void> reportMessage(String messageId, String userId);
}
