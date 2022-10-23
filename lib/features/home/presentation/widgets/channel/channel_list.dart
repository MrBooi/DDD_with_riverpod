import 'package:ddd_riverpod/features/chat/domain/chat_channel_entity.dart';
import 'package:ddd_riverpod/features/home/presentation/widgets/channel/chat_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChannelList extends StatelessWidget {
  final WidgetRef ref;
  final List<ChatChannelEntity> chatChannels;
  const ChannelList({
    required this.ref,
    required this.chatChannels,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics:
          const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      itemCount: chatChannels.length,
      itemBuilder: (context, index) {
        final channel = chatChannels[index];
        return ChannelMessageTile(
          channelEntity: channel,
        );
      },
    );
  }
}
