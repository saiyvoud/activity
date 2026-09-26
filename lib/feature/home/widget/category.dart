import 'package:activity/core/theme.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final List<String> categories;
  final int selected;
  final ValueChanged<int> onChanged;

  const CategoryWidget({
    super.key,
    required this.categories,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final isSelected = selected == index;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: ChoiceChip(
              label: Text(categories[index]),
              selected: isSelected,
              showCheckmark: false,
              onSelected: (_) => onChanged(index),
              selectedColor: kPrimary,
              backgroundColor: Colors.white,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontSize: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: isSelected ? kPrimary : Colors.grey.shade300),
              ),
            ),
          );
        },
      ),
    );
  }
}
