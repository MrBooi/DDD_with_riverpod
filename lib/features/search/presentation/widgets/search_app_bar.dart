import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    Key? key,
    required this.onChanged,
    required this.onCancel,
  }) : super(key: key);

  final void Function(String) onChanged;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        const SizedBox(width: 60),
        Expanded(
          child: TextField(
            autofocus: true,
            onChanged: (value) => onChanged(value),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.all(8.0),
              fillColor: theme.brightness == Brightness.light
                  ? Colors.black12
                  : Colors.white12,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  Icons.search,
                  color: theme.hintColor,
                ),
              ),
              prefixIconConstraints:
                  const BoxConstraints(maxHeight: 50, maxWidth: 50),
              hintText: 'Enter user name',
            ),
          ),
        ),
        CupertinoButton(
          onPressed: onCancel,
          padding: const EdgeInsets.all(8),
          child: const Text('cancel'),
        ),
      ],
    );
  }
}
