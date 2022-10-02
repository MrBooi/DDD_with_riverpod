import 'package:cloud_firestore/cloud_firestore.dart';

extension FirestoreX on FirebaseFirestore {
  CollectionReference get userCollection =>
      FirebaseFirestore.instance.collection(
        "users",
      );

  CollectionReference get channelsCollection =>
      FirebaseFirestore.instance.collection(
        "channels",
      );

  CollectionReference get messagesCollection =>
      FirebaseFirestore.instance.collection(
        "messages",
      );
}
