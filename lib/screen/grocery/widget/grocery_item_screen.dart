import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_recipe_proto_app/core/shared/routes/screen_route.dart';
import 'package:flutter_recipe_proto_app/data_model/grocery_item.dart';
import 'package:flutter_recipe_proto_app/screen/grocery/widget/grocery_tile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class GroceryItemScreen extends StatefulWidget {
  const GroceryItemScreen({
    Key? key,
    required this.onCreate,
    required this.onUpdate,
    this.originalItem,
    required this.index,
  })  : isUpdating = (originalItem != null),
        super(key: key);

  final Function(GroceryItem) onCreate;
  final Function(GroceryItem, int) onUpdate;
  final GroceryItem? originalItem;
  final int index;
  final bool? isUpdating;

  static MaterialPage page({
    GroceryItem? item,
    int? index,
    Function(GroceryItem)? onCreate,
    Function(GroceryItem, int)? onUpdate,
  }) {
    return MaterialPage(
        name: FoodRecipeAppPages.groceryItemDetails,
        key: ValueKey(FoodRecipeAppPages.groceryItemDetails),
        child: GroceryItemScreen(
          originalItem: item,
          onCreate: onCreate ?? (_) {},
          index: index ?? 0,
          onUpdate: onUpdate ?? (_, __) {},
        ));
  }

  @override
  _GroceryItemScreenState createState() => _GroceryItemScreenState();
}

class _GroceryItemScreenState extends State<GroceryItemScreen> {
  late final _nameController = TextEditingController();
  String _name = '';
  Importance _importance = Importance.low;
  DateTime _dueDate = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Color _currentColor = Colors.green;
  int _currentSliderValue = 0;

  @override
  void initState() {
    if (widget.originalItem != null) {
      _nameController.text = widget.originalItem?.name ?? '';
      _name = widget.originalItem?.name ?? '';
      _currentSliderValue = widget.originalItem?.quantity ?? 0;
      _importance = widget.originalItem?.importance as Importance;
      _currentColor = widget.originalItem?.color ?? Colors.green;
      final date = widget.originalItem?.date;
      _timeOfDay = TimeOfDay(
        hour: date!.hour,
        minute: date.minute,
      );
      _dueDate = date;
    }
    _nameController.addListener(() {
      _name = _nameController.text;
    });
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              final groceryItem = GroceryItem(
                id: widget.originalItem?.id ?? const Uuid().v1(),
                name: _nameController.text,
                importance: _importance,
                color: _currentColor,
                quantity: _currentSliderValue,
                date: DateTime(
                  _dueDate.year,
                  _dueDate.month,
                  _dueDate.day,
                  _timeOfDay.hour,
                  _timeOfDay.minute,
                ),
              );
              if (widget.isUpdating!) {
                widget.onUpdate(
                  groceryItem,
                  widget.index,
                );
              } else {
                widget.onCreate(groceryItem);
              }
            },
            icon: const Icon(Icons.check),
          ),
        ],
        elevation: 0,
        title: Text(
          'Grocery Item',
          style: GoogleFonts.lato(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            buildNameField(),
            buildImportanceField(),
            buildDateField(context),
            buildTimeField(context),
            const SizedBox(height: 10),
            buildColorPicker(context),
            const SizedBox(height: 10),
            buildQuantityField(),
            const SizedBox(height: 10),
            GroceryTile(
              item: GroceryItem(
                name: _name,
                importance: _importance,
                color: _currentColor,
                quantity: _currentSliderValue,
                date: DateTime(
                  _dueDate.year,
                  _dueDate.month,
                  _dueDate.day,
                  _timeOfDay.hour,
                  _timeOfDay.minute,
                ),
              ),
              onComplete: (value) {},
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Iten Name',
          style: GoogleFonts.lato(
            fontSize: 28,
          ),
        ),
        TextField(
          controller: _nameController,
          cursorColor: _currentColor,
          decoration: InputDecoration(
            hintText: 'E.g Apples, Banana, 1 Bag of salt',
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildImportanceField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Importance',
          style: GoogleFonts.lato(
            fontSize: 28,
          ),
        ),
        Wrap(
          spacing: 10,
          children: [
            ChoiceChip(
              selected: _importance == Importance.low,
              selectedColor: Colors.black,
              label: const Text(
                'low',
                style: TextStyle(color: Colors.white),
              ),
              onSelected: (selected) {
                setState(() {
                  _importance = Importance.low;
                });
              },
            ),
            ChoiceChip(
              selected: _importance == Importance.medium,
              selectedColor: Colors.black,
              label: const Text(
                'medium',
                style: TextStyle(color: Colors.white),
              ),
              onSelected: (selected) {
                setState(() {
                  _importance = Importance.medium;
                });
              },
            ),
            ChoiceChip(
              selected: _importance == Importance.high,
              selectedColor: Colors.black,
              label: const Text(
                'high',
                style: TextStyle(color: Colors.white),
              ),
              onSelected: (selected) {
                setState(() {
                  _importance = Importance.high;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget buildDateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Date',
              style: GoogleFonts.lato(
                fontSize: 28,
              ),
            ),
            TextButton(
              onPressed: () async {
                final currentDate = DateTime.now();
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: currentDate,
                  firstDate: currentDate,
                  lastDate: DateTime(currentDate.year + 5),
                );
                setState(() {
                  if (selectedDate != null) {
                    _dueDate = selectedDate;
                  }
                });
              },
              child: const Text('Select'),
            ),
          ],
        ),
        if (_dueDate != null)
          Text('${DateFormat('dd-MM-yyyy').format(_dueDate)}'),
      ],
    );
  }

  Widget buildTimeField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Time of Day',
              style: GoogleFonts.lato(
                fontSize: 28,
              ),
            ),
            TextButton(
              onPressed: () async {
                final timeOfDay = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                setState(() {
                  if (timeOfDay != null) {
                    _timeOfDay = timeOfDay;
                  }
                });
              },
              child: const Text('Select'),
            ),
          ],
        ),
        if (_timeOfDay != null) Text('${_timeOfDay.format(context)}'),
      ],
    );
  }

  Widget buildColorPicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 50,
              width: 10,
              color: _currentColor,
            ),
            const SizedBox(width: 8),
            Text(
              'Color',
              style: GoogleFonts.lato(
                fontSize: 28,
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: BlockPicker(
                      pickerColor: Colors.white,
                      onColorChanged: (color) {
                        setState(() => _currentColor = color);
                      },
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  );
                });
          },
          child: const Text('Select'),
        ),
      ],
    );
  }

  Widget buildQuantityField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              'Quantity',
              style: GoogleFonts.lato(
                fontSize: 28,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              _currentSliderValue.toInt().toString(),
              style: GoogleFonts.lato(fontSize: 18),
            ),
          ],
        ),
        Slider(
          min: 0.0,
          max: 100.0,
          divisions: 100,
          inactiveColor: _currentColor.withOpacity(0.5),
          activeColor: _currentColor,
          value: _currentSliderValue.toDouble(),
          label: _currentSliderValue.toInt().toString(),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value.toInt();
            });
          },
        ),
      ],
    );
  }
}
