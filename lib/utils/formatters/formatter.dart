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
      return '${phoneNumber.substring(0, 3)}-${phoneNumber.substring(3)}';
    } else if (phoneNumber.length == 10 && phoneNumber.startsWith('960')) {
      return '+960 ${phoneNumber.substring(3, 6)}-${phoneNumber.substring(6)}';
    } else if (phoneNumber.length == 12 && phoneNumber.startsWith('00960')) {
      return '+960 ${phoneNumber.substring(5, 8)}-${phoneNumber.substring(8)}';
    } else if (phoneNumber.length == 11 && phoneNumber.startsWith('+960')) {
      return '+960 ${phoneNumber.substring(4, 7)}-${phoneNumber.substring(7)}';
    }
    return phoneNumber;
  }
}