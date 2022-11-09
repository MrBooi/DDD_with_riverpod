import 'package:auto_route/auto_route.dart';
import 'package:ddd_riverpod/core/presentation/routes/app_router.gr.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
          borderRadius: BorderRadius.circular(8),
          splashColor: Colors.transparent,
          onTap: () {
            context.router.push(const SearchRoute());
          },
          child: Hero(
            tag: 'search-bar',
            child: Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black12,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.search,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Search',
                    style: theme.textTheme.bodyText1!.copyWith(
                      color: theme.hintColor,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
