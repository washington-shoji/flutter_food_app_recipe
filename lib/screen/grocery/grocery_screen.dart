import 'package:flutter/material.dart';
import 'package:flutter_recipe_proto_app/logic/grocery_manager.dart';
import 'package:flutter_recipe_proto_app/screen/grocery/empty_grocery_screen.dart';
import 'package:flutter_recipe_proto_app/screen/grocery/grocery_list_screen.dart';
import 'package:provider/provider.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildGroceryScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<GroceryManager>(context, listen: false).createNewItem();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

Widget buildGroceryScreen() {
  return Consumer<GroceryManager>(
    builder: (context, manager, child) {
      if (manager.groceryItems.isNotEmpty) {
        return GroceryListScreen(manager: manager);
      } else {
        return const EmptyGroceryScreen();
      }
    },
  );
}
