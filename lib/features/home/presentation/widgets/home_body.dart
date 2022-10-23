import 'package:ddd_riverpod/features/auth/shared/provider.dart';
import 'package:ddd_riverpod/features/chat/shared/provider.dart';
import 'package:ddd_riverpod/features/home/presentation/widgets/channel/channel_empty_widget.dart';
import 'package:ddd_riverpod/features/home/presentation/widgets/channel/channel_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer(
          builder: (context, ref, child) {
            final authProvider = ref.watch(firebaseAuthProvider);
            final chatsList = ref.watch(chatChannelStreamProvider(
              authProvider.currentUser!.uid,
            ));

            return Expanded(
              child: chatsList.maybeWhen(
                orElse: () => const SizedBox.shrink(),
                data: (response) {
                  if (response.isEmpty) {
                    return const ChannelEmptyWidget();
                  }
                  return ChannelList(
                    chatChannels: response,
                    ref: ref,
                  );
                },
              ),
            );
          },
        )
      ],
    );
  }
}