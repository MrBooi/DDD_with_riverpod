import 'package:auto_route/auto_route.dart';
import 'package:ddd_riverpod/features/search/presentation/widgets/search_app_bar.dart';
import 'package:ddd_riverpod/features/search/presentation/widgets/search_body.dart';
import 'package:ddd_riverpod/features/search/shared/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Consumer(
              builder: ((context, ref, child) {
                return SearchAppBar(
                  onCancel: () {
                    context.router.pop();
                  },
                  onChanged: (searchTerm) => ref
                      .watch(searchInputProvider.notifier)
                      .state = searchTerm,
                );
              }),
            ),
            const SearchBody()
          ],
        ),
      ),
    );
  }
}
