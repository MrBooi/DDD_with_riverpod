import 'package:ddd_riverpod/features/auth/shared/provider.dart';
import 'package:ddd_riverpod/features/chat/shared/provider.dart';
import 'package:ddd_riverpod/features/home/presentation/widgets/channel/channel_empty_widget.dart';
import 'package:ddd_riverpod/features/home/presentation/widgets/channel/channel_list.dart';
import 'package:ddd_riverpod/features/home/presentation/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SearchBar(),
        Consumer(
          builder: (context, ref, child) {
            final uuid = ref.watch(firebaseAuthUserIdProvider);
            final chatsList = ref.watch(chatChannelStreamProvider(
              uuid!,
            ));

            return Expanded(
              child: chatsList.maybeWhen(
                orElse: () => const SizedBox.shrink(),
                data: (response) {
                  if (response.isEmpty) {
                    return child!;
                  }
                  return ChannelList(
                    chatChannels: response,
                    ref: ref,
                  );
                },
              ),
            );
          },
          child: const ChannelEmptyWidget(),
        )
      ],
    );
  }
}
