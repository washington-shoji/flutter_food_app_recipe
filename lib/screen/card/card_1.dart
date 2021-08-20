import 'package:flutter/material.dart';
import 'package:flutter_recipe_proto_app/core/shared/theme/app_theme.dart';
import 'package:flutter_recipe_proto_app/data_model/models.dart';

class Card1 extends StatelessWidget {
  const Card1({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final ExploreRecipe? recipe;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
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
        child: Stack(
          children: [
            Text(
              recipe?.subtitle ?? '',
              style: RecipeAppTheme.darkTextTheme.bodyText1,
            ),
            Positioned(
              top: 20,
              child: Text(
                recipe?.title ?? '',
                style: RecipeAppTheme.darkTextTheme.headline2,
              ),
            ),
            Positioned(
              bottom: 30,
              right: 0,
              child: Text(
                recipe?.message ?? '',
                style: RecipeAppTheme.darkTextTheme.bodyText1,
              ),
            ),
            Positioned(
              bottom: 10,
              right: 0,
              child: Text(
                recipe?.authorName ?? '',
                style: RecipeAppTheme.darkTextTheme.bodyText1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
