import 'package:ddd_riverpod/features/profile/domain/user_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_channel_entity.freezed.dart';

@freezed
abstract class ChatChannelEntity with _$ChatChannelEntity {
  const ChatChannelEntity._();

  const factory ChatChannelEntity({
    required String id,
    required String lastMessage,
    required String sendBy,
    required List<UserEntity> members,
    required List<String> memberIds,
    required Map<String, bool> unRead,
    required DateTime lastTime,
  }) = _ChatChannelEntity;
}
