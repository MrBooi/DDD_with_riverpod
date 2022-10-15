import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ddd_riverpod/features/chat/domain/message/message_entity.dart';

part 'message_dto.freezed.dart';
part 'message_dto.g.dart';

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp json) => json.toDate();

  @override
  Timestamp toJson(DateTime object) => Timestamp.fromDate(object);
}

@freezed
class MessageDTO with _$MessageDTO {
  const MessageDTO._();

  const factory MessageDTO({
    required String id,
    required String textMessage,
    required String senderId,
    required DateTime sentAt,
    required String channelId,
    required ChatType chatType,
  }) = _MessageDTO;

  factory MessageDTO.fromJson(Map<String, dynamic> json) =>
      _$MessageDTOFromJson(json);

  factory MessageDTO.fromFireStore(DocumentSnapshot doc) =>
      MessageDTO.fromJson(doc.data() as Map<String, dynamic>).copyWith(
        id: doc.id,
      );

  factory MessageDTO.fromDomain(MessageEntity messageEntity) {
    return MessageDTO(
      id: messageEntity.id,
      channelId: messageEntity.channelId,
      chatType: messageEntity.chatType,
      senderId: messageEntity.senderId,
      sentAt: messageEntity.sentAt,
      textMessage: messageEntity.textMessage,
    );
  }

  MessageEntity toDomain() {
    return MessageEntity(
      id: id,
      channelId: channelId,
      chatType: chatType,
      senderId: senderId,
      sentAt: sentAt,
      textMessage: textMessage,
    );
  }
}
