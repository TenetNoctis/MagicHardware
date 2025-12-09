/// A custom exception class to handle various format-related errors.
class MagicFormatException implements Exception {
  /// The error message associated with the exception.
  final String message;

  /// Creates a [MagicFormatException] with an optional error [message].
  /// If no message is provided, a default message is used.
  const MagicFormatException([this.message = 'An unexpected format error occurred. Please check your input.']);

  /// Creates a [MagicFormatException] from a specific error message.
  factory MagicFormatException.fromMessage(String message) {
    return MagicFormatException(message);
  }

  /// Gets the formatted error message.
  String get formattedMessage => message;

  /// Creates a [MagicFormatException] from a specific error code.
  factory MagicFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return const MagicFormatException('The email address format is invalid. Please enter a valid email.');
      case 'invalid-phone-number-format':
        return const MagicFormatException('The provided phone number format is invalid. Please enter a valid number.');
      case 'invalid-date-format':
        return const MagicFormatException('The date format is invalid. Please enter a valid date.');
      case 'invalid-url-format':
        return const MagicFormatException('The URL format is invalid. Please enter a valid URL.');
      case 'invalid-credit-card-format':
        return const MagicFormatException('The credit card format is invalid. Please enter a valid credit card number.');
      case 'invalid-numeric-format':
        return const MagicFormatException('The input should be a valid numeric format.');
      default:
        return const MagicFormatException();
    }
  }
}
