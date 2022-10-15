class ChatUtils {
  static String chatChannelId(String id1, String id2) {
    if (id1.hashCode < id2.hashCode) {
      return '$id1-$id2';
    }
    return '$id2-$id1';
  }
}
