import 'package:ddd_riverpod/features/auth/shared/provider.dart';
import 'package:ddd_riverpod/features/home/presentation/widgets/home_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          Consumer(
            builder: (context, ref, child) {
              return IconButton(
                onPressed: () =>
                    ref.read(authNotifierProvider.notifier).signOut(),
                icon: const Icon(Icons.login_outlined),
              );
            },
          )
        ],
      ),
      body: const HomeBody(),
    );
  }
}
