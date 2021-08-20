import 'package:flutter/material.dart';
import 'package:flutter_recipe_proto_app/data_model/models.dart';

import 'package:flutter_recipe_proto_app/screen/explore/widget/friend_post_tile.dart';

class FriendPostListView extends StatelessWidget {
  const FriendPostListView({
    Key? key,
    required this.friendPosts,
  }) : super(key: key);

  final List<Post>? friendPosts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Friends Cooking',
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(height: 16),
          ListView.separated(
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: friendPosts?.length ?? 0,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final post = friendPosts?[index];
              return FriendPostTitle(post: post);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
