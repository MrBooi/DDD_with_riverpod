import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddd_riverpod/features/auth/chat/domain/i_chat_facade.dart';
import 'package:ddd_riverpod/core/extensions/firebase_x.dart';
import 'package:ddd_riverpod/features/chat/domain/chat_channel_dto.dart';
import 'package:ddd_riverpod/features/chat/domain/chat_channel_entity.dart';

class ChatFacade implements IChatFacade {
  final FirebaseFirestore _fireStore;

  ChatFacade(this._fireStore);

  @override
  Stream<List<ChatChannelEntity>> chatChannelEntityStream(String uuid) {
    final documentSnapshot = _fireStore.channelsCollection
        .where('memberIds', arrayContains: uuid)
        .orderBy('lastTime', descending: true)
        .snapshots();

    return documentSnapshot.map((querySnapshot) {
      final chatChannels = <ChatChannelEntity>[];

      for (var doc in querySnapshot.docs) {
        final dto = ChatChannelDTO.fromFireStore(doc);
        chatChannels.add(dto.toDomain());
      }
      return chatChannels;
    });
  }

  @override
  Future<ChatChannelEntity?> getChatChannel(String channelId) async {
    final doc = await _fireStore.channelsCollection.doc(channelId).get();

    if (!doc.exists) return null;

    final dto = ChatChannelDTO.fromFireStore(doc);
    return dto.toDomain();
  }

  @override
  Future<void> updateChatChannel(
    String channelId,
    Map<String, dynamic> payload, // TODO create a freezed data class
  ) async {
    await _fireStore.channelsCollection
        .doc(channelId)
        .set(payload, SetOptions(merge: true));
  }
}
