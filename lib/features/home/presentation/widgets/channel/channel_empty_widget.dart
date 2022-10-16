import 'package:ddd_riverpod/core/helpers/media_query_helper.dart';
import 'package:flutter/material.dart';

class ChannelEmptyWidget extends StatelessWidget {
  const ChannelEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Icon(
              Icons.chat_bubble_outlined,
              size: 50.0,
              color: Colors.green,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              'You currently have no messages.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          const Text(
            'Search a user to start your conservation.',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: MediaQueryHelpers.screenHeight(
              context,
              multiplier: 0.15,
            ),
          ),
        ],
      ),
    );
  }
}
