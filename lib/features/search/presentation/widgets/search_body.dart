import 'package:ddd_riverpod/features/search/presentation/widgets/search_item.dart';
import 'package:ddd_riverpod/features/search/shared/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchBody extends ConsumerWidget {
  const SearchBody({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userStreamProvider);
    return Expanded(
      child: users.when(
        loading: () => Center(
          child: Column(
            children: const [
              SizedBox(height: 20),
              Text('Searching...'),
            ],
          ),
        ),
        error: (error, stack) => const Center(
          child: Text(
            'Oops, something unexpected happened',
          ),
        ),
        data: (value) {
          if (value.isEmpty) {
            return Center(
              child: Column(
                children: const [
                  SizedBox(height: 20),
                  Text('No results'),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              final user = value[index];
              return SearchItem(user: user, ref: ref);
            },
          );
        },
      ),
    );
  }
}
