import 'package:freezed_annotation/freezed_annotation.dart';
part 'message_entity.freezed.dart';

enum ChatType {
  text,
  image,
  gif,
  sticker,
}

@freezed
abstract class MessageEntity with _$MessageEntity {
  MessageEntity._();

  const factory MessageEntity({
    required String id,
    required String textMessage,
    required String senderId,
    required DateTime sentAt,
    required String channelId,
    @Default(ChatType.text) ChatType chatType,
  }) = _MessageEntity;
}
