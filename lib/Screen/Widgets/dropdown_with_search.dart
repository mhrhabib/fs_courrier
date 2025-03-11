import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class DropdownWithSearch<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final String labelText;
  final String? Function(T?)? validator;
  final String hintText;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color fillColor;
  final Color dropdownColor;

  DropdownWithSearch({
    required this.value,
    required this.items,
    required this.onChanged,
    required this.labelText,
    this.validator,
    this.hintText = '',
    this.borderColor = Colors.grey,
    this.focusedBorderColor = Colors.blue,
    this.fillColor = Colors.white,
    this.dropdownColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      selectedItem: value,
      items: (filter, infiniteScrollProps) => items,
      onChanged: onChanged,
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: borderColor,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: focusedBorderColor,
              width: 2.0,
            ),
          ),
          filled: true,
          fillColor: fillColor,
          hintText: hintText,
        ),
      ),
      popupProps: PopupProps.menu(
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: borderColor,
                width: 1.0,
              ),
            ),
            filled: true,
            fillColor: fillColor,
            hintText: 'Search $labelText',
          ),
        ),
        menuProps: MenuProps(
          borderRadius: BorderRadius.circular(8.0),
          backgroundColor: dropdownColor,
        ),
      ),
      validator: validator,
      dropdownBuilder: (context, selectedItem) {
        return Text(
          selectedItem != null ? selectedItem.toString() : '',
          style: const TextStyle(color: Colors.black),
        );
      },
    );
  }
}
