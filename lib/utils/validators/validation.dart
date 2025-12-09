import 'package:intl/intl.dart';

import '../constants/text_strings.dart';

/// A utility class for validating user input.
class MagicValidator {
  /// Validates if a text field is empty.
  ///
  /// Returns an error message if the value is null, empty, or contains only whitespace.
  /// Otherwise, returns null.
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }

  /// Validates a postal code.
  ///
  /// - Checks if the postal code is empty.
  /// - Checks if it contains exactly 5 digits.
  /// - Checks if it starts with '0'.
  ///
  /// Returns an error message for invalid formats, otherwise null.
  static String? validatePostalCode(String? postalCode) {
    if (postalCode == null || postalCode.trim().isEmpty) {
      return 'Postal Code is required.';
    }

    final digitsOnly = postalCode.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length != 5) {
      return 'Postal Code must be exactly 5 digits.';
    }

    if (digitsOnly.startsWith('0')) {
      return 'Postal Code cannot start with 0.';
    }

    return null;
  }

  /// Validates the age based on a date of birth string.
  ///
  /// - Checks for an empty input.
  /// - Parses the date in 'dd-MMM-yyyy' format.
  /// - Ensures the date is not in the future.
  /// - Validates the age is between 18 and 120.
  ///
  /// Returns an error message for invalid inputs, otherwise null.
  static String? validateAge(String? input) {
    if (input == null || input.trim().isEmpty) {
      return 'Date of Birth is required.';
    }

    try {
      final DateFormat format = DateFormat('dd-MMM-yyyy');
      final DateTime dateOfBirth = format.parseStrict(input);
      final DateTime today = DateTime.now();

      if (dateOfBirth.isAfter(today)) {
        return 'Date of Birth cannot be in the future.';
      }

      final int age =
          today.year -
          dateOfBirth.year -
          ((today.month < dateOfBirth.month ||
                  (today.month == dateOfBirth.month &&
                      today.day < dateOfBirth.day))
              ? 1
              : 0);

      if (age < 18) {
        return MagicTexts.dateOfBirthError;
      }

      if (age > 120) {
        return 'Please enter a valid date of birth.';
      }
    } catch (e) {
      return 'Invalid date format. Use dd-MMM-yyyy (e.g., 15-Jan-1990).';
    }

    return null;
  }

  /// Validates a username.
  ///
  /// - Checks if the username is empty.
  /// - Enforces a length between 3 and 20 characters.
  /// - Allows only alphanumeric characters, underscores, and hyphens.
  /// - Prohibits starting or ending with an underscore or hyphen.
  ///
  /// Returns an error message for invalid usernames, otherwise null.
  static String? validateUsername(String? username) {
    if (username == null || username.trim().isEmpty) {
      return 'Username is required.';
    }

    final trimmed = username.trim();

    // Check length
    if (trimmed.length < 3 || trimmed.length > 20) {
      return 'Username must be between 3 and 20 characters.';
    }

    // Check pattern: alphanumeric, underscore, hyphen only
    const pattern = r"^[a-zA-Z0-9_-]+$";
    final regex = RegExp(pattern);

    if (!regex.hasMatch(trimmed)) {
      return 'Username can only contain letters, numbers, _ and -';
    }

    // Check if starts or ends with special characters
    if (trimmed.startsWith('_') ||
        trimmed.startsWith('-') ||
        trimmed.endsWith('_') ||
        trimmed.endsWith('-')) {
      return 'Username cannot start or end with _ or -';
    }

    return null;
  }

  /// Validates an email address.
  ///
  /// - Checks if the email is empty.
  /// - Uses a regular expression to verify the email format.
  /// - Checks for consecutive dots.
  ///
  /// Returns an error message for invalid email addresses, otherwise null.
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required.';
    }

    final trimmed = value.trim();

    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegExp.hasMatch(trimmed)) {
      return 'Invalid email address.';
    }

    // Check for consecutive dots
    if (trimmed.contains('..')) {
      return 'Invalid email address.';
    }

    return null;
  }

  /// Validates a password.
  ///
  /// - Checks if the password is empty.
  /// - Rejects common weak passwords.
  /// - Enforces a minimum length of 6 characters.
  /// - Requires at least one uppercase letter, one number, and one special character.
  ///
  /// Returns an error message for weak passwords, otherwise null.
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    // Check for common weak passwords
    final commonPasswords = ['password', '123456', 'qwerty', 'abc123'];
    if (commonPasswords.contains(value.toLowerCase())) {
      return 'This password is too common. Please choose a stronger one.';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character.';
    }

    return null;
  }

  /// Validates a phone number format, with a focus on Maldives numbers.
  ///
  /// - Checks if the phone number is empty.
  /// - Validates against a regex for common formats.
  /// - Checks the starting digit of the 7-digit number for Maldives-specific validation.
  ///
  /// Returns an error message for invalid formats, otherwise null.
  static String? validatePhoneNumberFormat(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required.';
    }

    final trimmed = value.trim();

    // Allow: 1234567, 9607654321, +960 765-4321, +960 7654321, +9607654321, +960 765 4321
    final phoneRegExp = RegExp(r'^(\+?960\s?\d{3}[-\s]?\d{4}|\d{7}|960\d{7})$');

    if (!phoneRegExp.hasMatch(trimmed)) {
      return 'Invalid phone number format (e.g., 1234567 or +960 123-4567).';
    }

    // Extract digits only
    final digitsOnly = trimmed.replaceAll(RegExp(r'\D'), '');

    // Check for valid Maldives numbers (last 7 digits)
    final lastSeven = digitsOnly.length >= 7
        ? digitsOnly.substring(digitsOnly.length - 7)
        : digitsOnly;

    // Maldives numbers typically start with 3, 7, 9, or 6
    if (!lastSeven.startsWith(RegExp(r'[3679]'))) {
      return 'Invalid Maldives phone number.';
    }

    return null;
  }

  /// Sanitizes input to prevent XSS and injection attacks.
  ///
  /// Replaces HTML special characters with their corresponding entities and trims whitespace.
  static String sanitizeInput(String input) {
    return input
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#x27;')
        .replaceAll('&', '&amp;')
        .trim();
  }
}
