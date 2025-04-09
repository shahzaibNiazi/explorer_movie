import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../config/app_colors.dart';
import 'my_text.dart';

class RoundedDropdown extends StatelessWidget {
  final List<String> items;
  final String? selectedValue;
  final String? hint;
  final ValueChanged<String?> onChanged;

  const RoundedDropdown({
    super.key,
    required this.items,
    this.selectedValue,
    required this.onChanged, this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: AppColors.inputfield.withOpacity(0.2), // Dropdown background color
        borderRadius: BorderRadius.circular(10.0),
        // border: Border.all(color: AppColors.inputfield.withOpacity(.6), width: 2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: MyText(title: hint?? "Select",clr: AppColors.inputfield,size: 14,),
          value: selectedValue,
          isExpanded: true,
          borderRadius: BorderRadius.circular(10),
          items: items
              .map((item) => DropdownMenuItem<String>(

            value: item,
            child: MyText(
              title:item,
              size: 15.sp,

            ),
          ))
              .toList(),
          onChanged: onChanged,
          dropdownColor: Colors.white, // Background color of dropdown items
          icon: const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.grey),
        ),
      ),
    );
  }
}