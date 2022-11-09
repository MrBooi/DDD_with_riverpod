import 'package:auto_route/auto_route.dart';
import 'package:ddd_riverpod/features/search/presentation/widgets/search_app_bar.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SearchAppBar(
              onCancel: () {
                context.router.pop();
              },
              onChanged: (searchTerm) {
                print('searchTerm changed to $searchTerm');
              },
            ),
          ],
        ),
      ),
    );
  }
}
