import 'package:flutter/services.dart';

class DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      int selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.end;
      if (oldValue.text.length == 3) {
        final newString = newValue.text + '/';
        return TextEditingValue(
          text: newString,
          selection: TextSelection.collapsed(
              offset: newString.length - selectionIndexFromTheRight),
        );
      } else if (oldValue.text.length == 6) {
        final newString = newValue.text + '/';
        return TextEditingValue(
          text: newString,
          selection: TextSelection.collapsed(
              offset: newString.length - selectionIndexFromTheRight),
        );
      } else {
        return newValue;
      }
    } else {
      return newValue;
    }
  }
}
