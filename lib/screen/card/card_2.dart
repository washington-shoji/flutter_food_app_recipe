import 'package:flutter/material.dart';
import 'package:flutter_recipe_proto_app/core/shared/theme/app_theme.dart';
import 'package:flutter_recipe_proto_app/data_model/models.dart';

import 'widget/author_card.dart';

class Card2 extends StatelessWidget {
  const Card2({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final ExploreRecipe? recipe;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints.expand(
          width: 350,
          height: 450,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(recipe?.backgroundImage ?? ''),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            AuthorCard(
              authorName: recipe?.authorName ?? '',
              title: 'Smoothie Connoisseur',
              imageProvider: AssetImage(recipe?.profileImage ?? ''),
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: Text(
                      recipe?.title ?? '',
                      style: RecipeAppTheme.lightTextTheme.headline1,
                    ),
                  ),
                  Positioned(
                    bottom: 70,
                    left: 16,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        recipe?.subtitle ?? '',
                        style: RecipeAppTheme.lightTextTheme.headline1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
