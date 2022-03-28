import 'package:flutter/services.dart';

class PhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      int selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.end;
      //final f = new NumberFormat("#,###");
      //int num = int.parse(newValue.text.replaceAll(f.symbols.GROUP_SEP, ''));
      //final newString = f.format(num);
      if (oldValue.text.contains("00243")) {
        final newString = newValue.text;
        return TextEditingValue(
          text: newString,
          selection: TextSelection.collapsed(
              offset: newString.length - selectionIndexFromTheRight),
        );
      } else {
        if (oldValue.text.length > newValue.text.length) {
          return newValue;
        }
        final newString = "00243" + newValue.text;
        return TextEditingValue(
          text: newString,
          selection: TextSelection.collapsed(
              offset: newString.length - selectionIndexFromTheRight),
        );
      }
    } else {
      return newValue;
    }
  }
}
