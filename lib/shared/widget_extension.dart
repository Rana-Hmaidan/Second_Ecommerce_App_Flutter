import 'package:flutter/material.dart';

extension WidgetUtils on List<Widget> {
  List<Widget> addSeparator(Widget separator) {
    final List<Widget> newList = [];
    if(length <= 1) return this;
    for(int i = 0; i < length; i++) {
      newList.add(this[i]);
      if(i < length - 1) {
        newList.add(separator);
      }
    }
    return newList;
  }
}

extension ContextExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}