import 'package:ddd_riverpod/core/shared/widgets/profile_avatar_widget.dart';
import 'package:ddd_riverpod/features/auth/shared/provider.dart';
import 'package:ddd_riverpod/features/chat/shared/provider.dart';
import 'package:ddd_riverpod/features/chat/shared/utils/chat_utils.dart';
import 'package:ddd_riverpod/features/profile/domain/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({
    required this.user,
    required this.ref,
    super.key,
  });
  final UserEntity user;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ProfileAvatarWidget(
        photoURL: user.photoUrl,
      ),
      title: Text(user.displayName),
      subtitle: Text('@${user.userName}'),
      onTap: () => onTap(context, user),
    );
  }

  Future<void> onTap(BuildContext context, UserEntity user) async {
    final currentId = ref.read(firebaseAuthUserIdProvider);
    final channelID = ChatUtils.chatChannelId(user.id, currentId!);
    final channel = await ref.read(chatFacadeProvider).getChatChannel(
          channelID,
        );

    print(channel?.id);
  }
}
