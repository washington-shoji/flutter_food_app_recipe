import 'package:flutter/material.dart';
import 'package:flutter_recipe_proto_app/core/shared/theme/app_theme.dart';
import 'package:flutter_recipe_proto_app/core/shared/widget/circle_image.dart';

class AuthorCard extends StatefulWidget {
  const AuthorCard({
    Key? key,
    required this.authorName,
    required this.title,
    required this.imageProvider,
  }) : super(key: key);

  final String authorName;
  final String title;
  final ImageProvider imageProvider;

  @override
  _AuthorCardState createState() => _AuthorCardState();
}

class _AuthorCardState extends State<AuthorCard> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleImage(
                imageRadius: 28,
                imageProvider: widget.imageProvider,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.authorName,
                    style: RecipeAppTheme.lightTextTheme.headline2,
                  ),
                  Text(
                    widget.title,
                    style: RecipeAppTheme.lightTextTheme.headline3,
                  ),
                ],
              )
            ],
          ),
          IconButton(
            onPressed: () {
              // const snackBar = SnackBar(content: Text('Press Favorite'));
              // ScaffoldMessenger.of(context).showSnackBar(snackBar);
              setState(() {
                _isFavorite = !_isFavorite;
              });
            },
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              size: 30,
              color: _isFavorite ? Colors.red : Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}
