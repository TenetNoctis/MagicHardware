import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:magic_hardware/utils/validators/validation.dart';

void runAgeValidationTests() {
  group('MagicValidator.validateAge - White Box Tests', () {
    final DateFormat format = DateFormat('dd-MMM-yyyy');

    // Branch 1: Null/Empty Check
    test('WB-AGE-001: Should return error when input is null', () {
      final result = MagicValidator.validateAge(null);
      expect(result, 'Date of Birth is required.');
    });

    test('WB-AGE-002: Should return error when input is empty', () {
      final result = MagicValidator.validateAge('');
      expect(result, 'Date of Birth is required.');
    });

    test('WB-AGE-003: Should return error when input is whitespace', () {
      final result = MagicValidator.validateAge('   ');
      expect(result, 'Date of Birth is required.');
    });

    // Branch 2: Date Parsing
    test('WB-AGE-004: Should accept valid date format', () {
      final date = format.format(
        DateTime.now().subtract(Duration(days: 20 * 365)),
      );
      final result = MagicValidator.validateAge(date);
      expect(result, null);
    });

    test('WB-AGE-005: Should reject invalid date format', () {
      final result = MagicValidator.validateAge('01/01/2000');
      expect(
        result,
        'Invalid date format. Use dd-MMM-yyyy (e.g., 15-Jan-1990).',
      );
    });

    test('WB-AGE-006: Should reject non-date string', () {
      final result = MagicValidator.validateAge('not a date');
      expect(
        result,
        'Invalid date format. Use dd-MMM-yyyy (e.g., 15-Jan-1990).',
      );
    });

    // Branch 3: Future Date Check
    test('WB-AGE-007: Should reject future date', () {
      final futureDate = format.format(DateTime.now().add(Duration(days: 1)));
      final result = MagicValidator.validateAge(futureDate);
      expect(result, 'Date of Birth cannot be in the future.');
    });

    test('WB-AGE-008: Should accept today as birth date (edge case)', () {
      final today = format.format(DateTime.now());
      final result = MagicValidator.validateAge(today);
      // Will fail age check but not future date check
      expect(result, 'You must be at least 18 years old.');
    });

    // Branch 4: Minimum Age Check (18 years)
    test('WB-AGE-009: Should reject age < 18 years', () {
      final date17YearsAgo = DateTime.now().subtract(Duration(days: 17 * 365));
      final dateStr = format.format(date17YearsAgo);
      final result = MagicValidator.validateAge(dateStr);
      expect(result, 'You must be at least 18 years old.');
    });

    test('WB-AGE-010: Should accept age = 18 years (boundary)', () {
      final date18YearsAgo = DateTime.now().subtract(
        Duration(days: 18 * 365 + 10),
      );
      final dateStr = format.format(date18YearsAgo);
      final result = MagicValidator.validateAge(dateStr);
      expect(result, null);
    });

    test('WB-AGE-011: Should accept age > 18 years', () {
      final date25YearsAgo = DateTime.now().subtract(Duration(days: 25 * 365));
      final dateStr = format.format(date25YearsAgo);
      final result = MagicValidator.validateAge(dateStr);
      expect(result, null);
    });

    // Branch 5: Maximum Age Check (120 years)
    test('WB-AGE-012: Should accept age = 120 years (boundary)', () {
      final date120YearsAgo = DateTime.now().subtract(
        Duration(days: 120 * 365),
      );
      final dateStr = format.format(date120YearsAgo);
      final result = MagicValidator.validateAge(dateStr);
      expect(result, null);
    });

    test('WB-AGE-013: Should reject age > 120 years', () {
      final now = DateTime.now();
      final date121YearsAgo = DateTime(now.year - 121, now.month, now.day);
      final dateStr = format.format(date121YearsAgo);
      final result = MagicValidator.validateAge(dateStr);
      expect(result, 'Please enter a valid date of birth.');
    });

    // Path Coverage: Birthday edge cases
    test('WB-AGE-014: Should handle birthday today (turns 18)', () {
      final now = DateTime.now();
      final exactly18YearsAgo = DateTime(now.year - 18, now.month, now.day);
      final dateStr = format.format(exactly18YearsAgo);
      final result = MagicValidator.validateAge(dateStr);
      expect(result, null);
    });

    test('WB-AGE-015: Should handle leap years', () {
      final leapYearDate = '29-Feb-2000';
      final result = MagicValidator.validateAge(leapYearDate);
      expect(result, null);
    });
  });
}
