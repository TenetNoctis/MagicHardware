import 'package:intl/intl.dart';

class MagicFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: 'MVR').format(amount);
  }

  static String formatPhoneNumber(String phoneNumber) {
    // Remove all non-digit characters
    final digitsOnly = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');

    // If we have exactly 7 digits, format with +960
    if (digitsOnly.length == 7) {
      return '+960 ${digitsOnly.substring(0, 3)}-${digitsOnly.substring(3)}';
    }
    // If we have 10 digits starting with 960, use the last 7
    else if (digitsOnly.length == 10 && digitsOnly.startsWith('960')) {
      final localDigits = digitsOnly.substring(3);
      return '+960 ${localDigits.substring(0, 3)}-${localDigits.substring(3)}';
    }
    // If we have 11 digits starting with 960 (like +9601234567 becomes 9601234567)
    else if (digitsOnly.length == 11 && digitsOnly.startsWith('960')) {
      final localDigits = digitsOnly.substring(3);
      if (localDigits.length == 7) {
        return '+960 ${localDigits.substring(0, 3)}-${localDigits.substring(3)}';
      }
    }

    // Return original if it doesn't match expected patterns
    return phoneNumber;
  }
}
