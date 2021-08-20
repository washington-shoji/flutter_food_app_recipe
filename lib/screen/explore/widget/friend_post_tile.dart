import 'package:flutter/material.dart';
import 'package:flutter_recipe_proto_app/core/shared/widget/circle_image.dart';
import 'package:flutter_recipe_proto_app/data_model/models.dart';

class FriendPostTitle extends StatelessWidget {
  const FriendPostTitle({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post? post;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleImage(
          imageProvider: AssetImage(
            post?.profileImageUrl ?? '',
          ),
          imageRadius: 20,
        ),
        const SizedBox(width: 16),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post?.comment ?? ''),
            Text(
              '${post?.timestamp} mins ago',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        )),
      ],
    );
  }
}
