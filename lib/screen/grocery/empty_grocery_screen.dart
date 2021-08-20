import 'package:flutter/material.dart';
import 'package:flutter_recipe_proto_app/logic/app_state_manager.dart';
import 'package:provider/provider.dart';

class EmptyGroceryScreen extends StatelessWidget {
  const EmptyGroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: 3.5 / 1,
            child: Image.asset('assets/app_assets/empty_list.png'),
          ),
          const SizedBox(height: 8),
          const Text(
            'No Groceries',
            style: TextStyle(fontSize: 21),
          ),
          const SizedBox(height: 16),
          const Text(
            'Shopping for ingredients?\n'
            'Tap the + button to write them down!',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          MaterialButton(
            onPressed: () {
              Provider.of<AppStateManager>(context, listen: false)
                  .goToRecipes();
            },
            child: const Text('Browse Recipes'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            color: Colors.amber,
          ),
        ],
      ),
    );
  }
}
