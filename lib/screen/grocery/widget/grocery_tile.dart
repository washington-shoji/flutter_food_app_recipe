import 'package:flutter/material.dart';
import 'package:flutter_recipe_proto_app/data_model/grocery_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class GroceryTile extends StatelessWidget {
  GroceryTile({
    Key? key,
    required this.item,
    required this.onComplete,
  })  : textDecoration =
            item.isComplete! ? TextDecoration.lineThrough : TextDecoration.none,
        super(key: key);

  final GroceryItem item;
  late final Function(bool?) onComplete;
  final TextDecoration textDecoration;

  @override
  Widget build(BuildContext context) {
    print(item.color);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: 5,
              color: item.color,
            ),
            const SizedBox(width: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name!,
                  style: GoogleFonts.lato(
                    decoration: textDecoration,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                buildDate(),
                const SizedBox(height: 4),
                buildImportance(),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Text(
              item.quantity.toString(),
              style: GoogleFonts.lato(
                decoration: textDecoration,
                fontSize: 21,
              ),
            ),
            buildCheckBox(),
          ],
        ),
      ],
    );
  }

  Widget buildImportance() {
    if (item.importance == Importance.low) {
      return Text(
        'Low',
        style: GoogleFonts.lato(
          fontWeight: FontWeight.w800,
          decoration: textDecoration,
        ),
      );
    } else if (item.importance == Importance.medium) {
      return Text(
        'Medium',
        style: GoogleFonts.lato(
          fontWeight: FontWeight.w800,
          decoration: textDecoration,
        ),
      );
    } else if (item.importance == Importance.high) {
      return Text(
        'High',
        style: GoogleFonts.lato(
          color: Colors.red,
          fontWeight: FontWeight.w900,
          decoration: textDecoration,
        ),
      );
    } else {
      throw Exception('This importance type does not exist');
    }
  }

  Widget buildDate() {
    final dateFormatter = DateFormat('dd MMMM h:mm a');
    final dateString = dateFormatter.format(item.date!);
    return Text(
      dateString,
      style: TextStyle(
        decoration: textDecoration,
      ),
    );
  }

  Widget buildCheckBox() {
    return Checkbox(
      value: item.isComplete,
      onChanged: onComplete,
    );
  }
}
