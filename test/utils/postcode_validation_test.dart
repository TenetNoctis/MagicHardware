import 'package:flutter_test/flutter_test.dart';
import 'package:magic_hardware/utils/validators/validation.dart';

void runPostCodeValidationTests() {
  group('MagicValidator.validatePostalCode - White Box Tests', () {
    // Branch 1: Null/Empty Check
    test('WB-POST-001: Should return error when input is null', () {
      final result = MagicValidator.validatePostalCode(null);
      expect(result, 'Postal Code is required.');
    });

    test('WB-POST-002: Should return error when input is empty', () {
      final result = MagicValidator.validatePostalCode('');
      expect(result, 'Postal Code is required.');
    });

    test('WB-POST-003: Should return error when input is whitespace', () {
      final result = MagicValidator.validatePostalCode('   ');
      expect(result, 'Postal Code is required.');
    });

    // Branch 2: Digit Extraction and Length Check
    test('WB-POST-004: Should accept valid 5-digit postal code', () {
      final result = MagicValidator.validatePostalCode('20012');
      expect(result, null);
    });

    test('WB-POST-005: Should reject less than 5 digits', () {
      final result = MagicValidator.validatePostalCode('1234');
      expect(result, 'Postal Code must be exactly 5 digits.');
    });

    test('WB-POST-006: Should reject more than 5 digits', () {
      final result = MagicValidator.validatePostalCode('123456');
      expect(result, 'Postal Code must be exactly 5 digits.');
    });

    // Branch 3: Non-digit handling
    test('WB-POST-007: Should extract digits from formatted input', () {
      final result = MagicValidator.validatePostalCode('20-012');
      expect(result, null);
    });

    test('WB-POST-008: Should extract digits from spaced input', () {
      final result = MagicValidator.validatePostalCode('20 012');
      expect(result, null);
    });

    test('WB-POST-009: Should handle whitespace around digits', () {
      final result = MagicValidator.validatePostalCode('  20012  ');
      expect(result, null);
    });

    // Branch 4: Leading zero check
    test('WB-POST-010: Should reject postal code starting with 0', () {
      final result = MagicValidator.validatePostalCode('01234');
      expect(result, 'Postal Code cannot start with 0.');
    });

    test('WB-POST-011: Should accept postal code not starting with 0', () {
      final result = MagicValidator.validatePostalCode('10000');
      expect(result, null);
    });

    // Path Coverage: Edge cases
    test('WB-POST-012: Should accept minimum valid postal code', () {
      final result = MagicValidator.validatePostalCode('10000');
      expect(result, null);
    });

    test('WB-POST-013: Should accept maximum valid postal code', () {
      final result = MagicValidator.validatePostalCode('99999');
      expect(result, null);
    });

    test('WB-POST-014: Should handle mixed characters and digits', () {
      final result = MagicValidator.validatePostalCode('ABC20-012XYZ');
      expect(result, null);
    });
  });
}