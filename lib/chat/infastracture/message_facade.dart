import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddd_riverpod/chat/domain/message/i_message_facade.dart';
import 'package:ddd_riverpod/chat/domain/message/message_dto.dart';
import 'package:ddd_riverpod/chat/domain/message/message_entity.dart';
import 'package:ddd_riverpod/core/extensions/firebase_x.dart';

class MessageFacade implements IMessageFacade {
  final FirebaseFirestore _fireStore;

  MessageFacade(this._fireStore);

  @override
  Future<void> addMessage(MessageEntity message) async {
    final messageDTO = MessageDTO.fromDomain(message);
    await _fireStore.messagesCollection.add(messageDTO.toJson());
  }

  @override
  Stream<List<MessageEntity>> messageStream(String channelId) {
    final docSnap = _fireStore.messagesCollection
        .where('channelId', isEqualTo: channelId)
        .orderBy('sentAt', descending: true)
        .snapshots();

    return docSnap.map((querySnapshot) {
      final messages = <MessageEntity>[];
      for (var doc in querySnapshot.docs) {
        final messageDTO = MessageDTO.fromFireStore(doc);
        messages.add(messageDTO.toDomain());
      }
      return messages;
    });
  }

  @override
  Future<void> reportMessage(String messageId, String userId) {
    // TODO: implement reportMessage
    throw UnimplementedError();
  }
}
