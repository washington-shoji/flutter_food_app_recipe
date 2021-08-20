import 'package:flutter/material.dart';
import 'package:flutter_recipe_proto_app/logic/grocery_manager.dart';
import 'package:flutter_recipe_proto_app/screen/grocery/widget/grocery_tile.dart';

class GroceryListScreen extends StatelessWidget {
  const GroceryListScreen({
    Key? key,
    required this.manager,
  }) : super(key: key);

  final GroceryManager manager;

  @override
  Widget build(BuildContext context) {
    final groceryItems = manager.groceryItems;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        itemCount: groceryItems.length,
        itemBuilder: (context, index) {
          final item = groceryItems[index];

          return Dismissible(
            key: Key(item.id.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.delete_forever,
                color: Colors.white,
                size: 50,
              ),
            ),
            onDismissed: (direction) {
              manager.deleteItem(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${item.name} deleted'),
                ),
              );
            },
            child: InkWell(
              onTap: () {
                manager.groceryItemTapped(index);
              },
              child: GroceryTile(
                key: Key(item.id.toString()),
                item: item,
                onComplete: (change) {
                  manager.completeItem(index, change!);
                },
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
      ),
    );
  }
}
