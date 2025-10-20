import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
class WidgetProvidersStruct {
  late final StateProvider<ThemeData> themeProvider;
  late final StateProvider<AppBar> appBarProvider;

  WidgetProvidersStruct(){
    themeProvider = StateProvider<ThemeData>((ref){
      return ThemeData.dark();
    });
    appBarProvider = StateProvider<AppBar>((ref){
      final theme = ref.watch(themeProvider);
      return AppBar(
        title: Text('Default Title'),
        backgroundColor: theme.primaryColor,
        foregroundColor: theme.colorScheme.onPrimary,
      );
    });
  }
}