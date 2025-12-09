import 'package:intl/intl.dart';

/// A utility class for formatting various types of data.
class MagicFormatter {
  /// Formats a [DateTime] object into a string with the format 'dd-MMM-yyyy'.
  ///
  /// If the provided [date] is null, it defaults to the current date.
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  /// Formats a double value into a currency string.
  ///
  /// - [amount]: The amount to be formatted.
  /// - [currency]: The currency symbol to be used (defaults to 'MVR').
  ///
  /// Returns a string formatted as a currency, e.g., 'MVR 1,234.56'.
  /// For negative numbers, the sign is placed after the currency symbol, e.g., 'MVR -1,234.56'.
  static String formatCurrency(double amount, {String currency = 'MVR'}) {
    String formatted = NumberFormat.currency(
      locale: 'en_US',
      symbol: '$currency ',
      decimalDigits: 2,
    ).format(amount);

    if (amount < 0) {
      formatted = formatted.replaceFirst('-', '');
      formatted = formatted.replaceFirst('$currency ', '$currency -');
    }

    return formatted;
  }

  /// Formats a phone number string to a standard Maldivian format.
  ///
  /// Handles various formats and attempts to convert them to '+960 xxx-xxxx'.
  /// If the number cannot be formatted, it is returned as is.
  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) return phoneNumber;

    final digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // If we have exactly 7 digits, format with +960
    if (digitsOnly.length == 7) {
      return '+960 ${digitsOnly.substring(0, 3)}-${digitsOnly.substring(3)}';
    }
    // If we have 10 digits starting with 960, use the last 7
    else if (digitsOnly.length == 10 && digitsOnly.startsWith('960')) {
      final localDigits = digitsOnly.substring(3);
      return '+960 ${localDigits.substring(0, 3)}-${localDigits.substring(3)}';
    }
    // If we have 11 digits starting with 960
    else if (digitsOnly.length == 11 && digitsOnly.startsWith('960')) {
      final localDigits = digitsOnly.substring(3);
      if (localDigits.length == 7) {
        return '+960 ${localDigits.substring(0, 3)}-${localDigits.substring(3)}';
      }
    }
    // If already properly formatted
    else if (phoneNumber.startsWith('+960')) {
      return phoneNumber;
    }

    return phoneNumber;
  }
}
