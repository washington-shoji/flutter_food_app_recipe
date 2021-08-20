import 'package:flutter/cupertino.dart';
import 'package:flutter_recipe_proto_app/data_model/grocery_item.dart';

class GroceryManager extends ChangeNotifier {
  final _groceryItems = <GroceryItem>[];
  int? _selectedIndex = null;
  bool _createNewItem = false;

  List<GroceryItem> get groceryItems => List.unmodifiable(_groceryItems);
  int? get selectedIndex => _selectedIndex;
  GroceryItem? get selectedGroceryItem =>
      // Pass a conditional to validate the nullable selected index
      // Otherwise it will return an unexpected null
      selectedIndex != null ? _groceryItems[selectedIndex!] : null;
  bool get isCreatingNewItem => _createNewItem;

  void createNewItem() {
    _createNewItem = true;
    notifyListeners();
  }

  void deleteItem(int index) {
    _groceryItems.removeAt(index);
    notifyListeners();
  }

  // Make this method nullable for when the user abort an action
  void groceryItemTapped(int? index) {
    _selectedIndex = index;
    _createNewItem = false;
    notifyListeners();
  }

  void setSelectedGroceryItem(String? id) {
    final index = groceryItems.indexWhere((element) => element.id == id);
    _selectedIndex = index;
    _createNewItem = false;
    notifyListeners();
  }

  void addItem(GroceryItem item) {
    _groceryItems.add(item);
    _createNewItem = false;
    notifyListeners();
  }

  void updateItem(GroceryItem item, int index) {
    _groceryItems[index] = item;
    _selectedIndex = null;
    _createNewItem = false;
    notifyListeners();
  }

  void completeItem(int index, bool change) {
    final item = _groceryItems[index];
    _groceryItems[index] = item.copyWith(isComplete: change);
    notifyListeners();
  }
}
