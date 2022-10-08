import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddd_riverpod/chat/domain/chat_channel_entity.dart';
import 'package:ddd_riverpod/profile/domain/user_dto.dart';
import 'package:ddd_riverpod/profile/domain/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_channel_dto.freezed.dart';
part 'chat_channel_dto.g.dart';

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp json) => json.toDate();

  @override
  Timestamp toJson(DateTime object) => Timestamp.fromDate(object);
}

@freezed
abstract class ChatChannelDTO implements _$ChatChannelDTO {
  const ChatChannelDTO._();

  const factory ChatChannelDTO({
    required String id,
    required String lastMessage,
    required String sendBy,
    required List<UserDTO> members,
    required List<String> memberIds,
    required Map<String, bool> unRead,
    @TimestampConverter() required DateTime lastTime,
  }) = _ChatChannelDTO;

  factory ChatChannelDTO.fromJson(Map<String, dynamic> json) =>
      _$ChatChannelDTOFromJson(json);

  factory ChatChannelDTO.fromFireStore(DocumentSnapshot doc) =>
      ChatChannelDTO.fromJson(doc.data() as Map<String, dynamic>).copyWith(
        id: doc.id,
      );

  factory ChatChannelDTO.fromDomain(ChatChannelEntity channelEntity) {
    return ChatChannelDTO(
      id: channelEntity.id,
      lastMessage: channelEntity.lastMessage,
      lastTime: channelEntity.lastTime,
      memberIds: channelEntity.memberIds,
      members: channelEntity.members
          .map(
            (m) => UserDTO.fromDomain(m).copyWith(uuid: m.id),
          )
          .toList(),
      sendBy: channelEntity.sendBy,
      unRead: channelEntity.unRead,
    );
  }

  ChatChannelEntity toDomain() {
    return ChatChannelEntity(
      id: id,
      lastMessage: lastMessage,
      lastTime: lastTime,
      memberIds: memberIds,
      members: members.map((m) => m.toDomain()).toList(),
      sendBy: sendBy,
      unRead: unRead,
    );
  }
}
