import 'package:ddd_riverpod/core/shared/widgets/profile_avatar_widget.dart';
import 'package:ddd_riverpod/features/profile/domain/user_entity.dart';
import 'package:flutter/material.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({required this.user, super.key});
  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ProfileAvatarWidget(
        photoURL: user.photoUrl,
      ),
      title: Text(user.displayName),
      subtitle: Text('@${user.userName}'),
      onTap: () => onTap(),
    );
  }

  void onTap() {
    debugPrint('handle on Tap on a user');
  }
}
