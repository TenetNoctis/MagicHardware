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
    if (phoneNumber.length == 7) {
      return '+960 ${phoneNumber.substring(0, 3)}-${phoneNumber.substring(3)}';
    }
    return phoneNumber;
  }
}