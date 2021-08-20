import 'package:flutter/material.dart';
import 'package:flutter_recipe_proto_app/data_model/models.dart';
import 'package:flutter_recipe_proto_app/infrastructure/api/mock_food_api_service.dart';
import 'package:flutter_recipe_proto_app/screen/recipe/widget/recipes_grid_view.dart';

class RecipeScreen extends StatelessWidget {
  RecipeScreen({Key? key}) : super(key: key);

  final exploreService = MockFoodApiService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SimpleRecipe>?>(
      future: exploreService.getRecipes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return RecipesGridView(recipes: snapshot.data);
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          );
        }
      },
    );
  }
}
