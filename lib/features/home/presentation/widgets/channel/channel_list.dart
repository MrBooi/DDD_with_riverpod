import 'package:ddd_riverpod/features/chat/domain/chat_channel_entity.dart';
import 'package:flutter/material.dart';

class ChannelList extends StatelessWidget {
  final List<ChatChannelEntity> chatChannels;
  const ChannelList({required this.chatChannels, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics:
          const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      itemCount: chatChannels.length,
      itemBuilder: (context, index) {
        final channel = chatChannels[index];
        return Container(
          color: Colors.yellowAccent,
          child: Text(
            channel.lastMessage,
          ),
        );
      },
    );
  }
}
