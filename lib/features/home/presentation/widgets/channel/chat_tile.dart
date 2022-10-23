import 'package:ddd_riverpod/core/utils/date_time_format.dart';
import 'package:ddd_riverpod/core/shared/widgets/profile_avatar_widget.dart';
import 'package:ddd_riverpod/features/auth/shared/provider.dart';
import 'package:ddd_riverpod/features/chat/domain/chat_channel_entity.dart';
import 'package:ddd_riverpod/features/profile/domain/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChannelMessageTile extends ConsumerWidget {
  const ChannelMessageTile({
    required this.channelEntity,
    Key? key,
  }) : super(key: key);

  final ChatChannelEntity channelEntity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late final UserEntity oppositeUser;
    late final UserEntity currentUser;
    late final bool isUnread;
    final theme = Theme.of(context);

    final currentUserId = ref.watch(firebaseAuthUserIdProvider);
    // Move code to a state notifier
    oppositeUser = channelEntity.members.firstWhere(
      (user) => user.id != currentUserId,
    ); // Move code to a state notifier
    currentUser = channelEntity.members.firstWhere(
      (user) => user.id == currentUserId,
    );
    isUnread = channelEntity.unRead[currentUser.id]!;

    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: ProfileAvatarWidget(
              radius: 26,
              photoURL: oppositeUser.photoUrl,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  oppositeUser.displayName,
                  style: TextStyle(
                    fontWeight: isUnread ? FontWeight.bold : FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        (channelEntity.sendBy == oppositeUser.id
                                ? ''
                                : 'You: ') +
                            channelEntity.lastMessage,
                        style: isUnread
                            ? TextStyle(
                                fontWeight: FontWeight.bold,
                                color: theme.brightness == Brightness.light
                                    ? Colors.black
                                    : Colors.white,
                              )
                            : TextStyle(
                                color: theme.hintColor,
                              ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      DateTimeFormat.dateFormat(channelEntity.lastTime),
                      style: isUnread
                          ? TextStyle(
                              fontWeight: FontWeight.bold,
                              color: theme.brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                            )
                          : TextStyle(
                              color: theme.hintColor,
                            ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8)
        ],
      ),
    );
  }
}
