import 'package:ddd_riverpod/features/auth/shared/provider.dart';
import 'package:ddd_riverpod/features/chat/shared/provider.dart';
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
              child: chatsList.map(
                error: (_) => const Center(
                  child: Text('something went wrong!'),
                ),
                data: (response) {
                  return const Center(
                    child: Text('user chat list'),
                  );
                },
                loading: (_) {
                  return const Center(child: Text('loading'));
                },
              ),
            );
          },
        )
      ],
    );
  }
}
