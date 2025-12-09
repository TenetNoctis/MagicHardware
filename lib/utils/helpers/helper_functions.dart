import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// A utility class containing various helper functions for the app.
class MagicHelperFunctions {
  /// Returns a [Color] object based on a color name string.
  ///
  /// Supports a predefined set of color names. If the color name is not recognized,
  /// it returns null.
  static Color? getColor(String value) {
    if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Red') {
      return Colors.red;
    } else if (value == 'Blue') {
      return Colors.blue;
    } else if (value == 'Pink') {
      return Colors.pink;
    } else if (value == 'Grey') {
      return Colors.grey;
    } else if (value == 'Purple') {
      return Colors.purple;
    } else if (value == 'Black') {
      return Colors.black;
    } else if (value == 'White') {
      return Colors.white;
    } else if (value == 'Yellow') {
      return Colors.yellow;
    } else if (value == 'Orange') {
      return Colors.orange;
    } else if (value == 'Brown') {
      return Colors.brown;
    } else if (value == 'Teal') {
      return Colors.teal;
    } else if (value == 'Indigo') {
      return Colors.indigo;
    } else if (value == 'Amber') {
      return Colors.amber;
    }
    return null;
  }

  /// Displays a SnackBar with the given [message].
  static void showSnackBar(String message) {
    ScaffoldMessenger.of(
      Get.context!,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  /// Shows an alert dialog with the given [title] and [message].
  static void showAlert(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  /// Navigates to a new screen.
  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  /// Truncates a string to a specified [maxLength] and appends '...'.
  ///
  /// If the string is shorter than or equal to [maxLength], it is returned as is.
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)} ... ';
    }
  }

  /// Checks if the current theme is dark mode.
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  /// Returns the size of the screen.
  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  /// Returns the height of the screen.
  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  /// Returns the width of the screen.
  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  /// Formats a [DateTime] object into a string with the specified [format].
  ///
  /// The default format is 'dd MMM yyyy'.
  static String getFormattedDate(
    DateTime date, {
    String format = 'dd MMM yyyy',
  }) {
    return DateFormat(format).format(date);
  }

  /// Removes duplicate items from a list.
  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  /// Wraps a list of widgets into rows of a specified [rowSize].
  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
        i,
        i + rowSize > widgets.length ? widgets.length : i + rowSize,
      );
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }
}
