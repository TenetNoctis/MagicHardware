import 'package:flutter_test/flutter_test.dart';
import 'package:magic_hardware/utils/validators/validation.dart';

void runPhoneValidationTests() {
  group('MagicValidator.validatePhoneNumberFormat - White Box Tests', () {

    // Branch 1: Null/Empty Check
    test('WB-PHONE-001: Should return error when phone is null', () {
      final result = MagicValidator.validatePhoneNumberFormat(null);
      expect(result, 'Phone number is required.');
    });

    test('WB-PHONE-002: Should return error when phone is empty string', () {
      final result = MagicValidator.validatePhoneNumberFormat('');
      expect(result, 'Phone number is required.');
    });

    test('WB-PHONE-003: Should return error when phone is only whitespace', () {
      final result = MagicValidator.validatePhoneNumberFormat('   ');
      expect(result, 'Phone number is required.');
    });

    // Branch 2: Format Validation
    test('WB-PHONE-004: Should accept 7-digit format', () {
      final result = MagicValidator.validatePhoneNumberFormat('7654321');
      expect(result, null);
    });

    test('WB-PHONE-005: Should accept +960 XXX-XXXX format', () {
      final result = MagicValidator.validatePhoneNumberFormat('+960 765-4321');
      expect(result, null);
    });

    test('WB-PHONE-006: Should accept +960XXXXXXX format (no spaces)', () {
      final result = MagicValidator.validatePhoneNumberFormat('+9607654321');
      expect(result, null);
    });

    test('WB-PHONE-007: Should reject invalid format with letters', () {
      final result = MagicValidator.validatePhoneNumberFormat('abc1234');
      expect(result, 'Invalid phone number format (e.g., 1234567 or +960 123-4567).');
    });

    test('WB-PHONE-008: Should reject format with less than 7 digits', () {
      final result = MagicValidator.validatePhoneNumberFormat('12345');
      expect(result, 'Invalid phone number format (e.g., 1234567 or +960 123-4567).');
    });

    // Branch 3: Maldives Number Validation (starts with 3, 7, 9, or 6)
    test('WB-PHONE-009: Should accept number starting with 3', () {
      final result = MagicValidator.validatePhoneNumberFormat('3654321');
      expect(result, null);
    });

    test('WB-PHONE-010: Should accept number starting with 7', () {
      final result = MagicValidator.validatePhoneNumberFormat('7654321');
      expect(result, null);
    });

    test('WB-PHONE-011: Should accept number starting with 9', () {
      final result = MagicValidator.validatePhoneNumberFormat('9654321');
      expect(result, null);
    });

    test('WB-PHONE-012: Should accept number starting with 6', () {
      final result = MagicValidator.validatePhoneNumberFormat('6654321');
      expect(result, null);
    });

    test('WB-PHONE-013: Should reject number starting with 1', () {
      final result = MagicValidator.validatePhoneNumberFormat('1654321');
      expect(result, 'Invalid Maldives phone number.');
    });

    test('WB-PHONE-014: Should reject number starting with 5', () {
      final result = MagicValidator.validatePhoneNumberFormat('5654321');
      expect(result, 'Invalid Maldives phone number.');
    });

    // Path Coverage: Different input formats
    test('WB-PHONE-015: Should handle phone with country code 960', () {
      final result = MagicValidator.validatePhoneNumberFormat('9607654321');
      expect(result, null);
    });

    test('WB-PHONE-016: Should handle formatted +960 with spaces', () {
      final result = MagicValidator.validatePhoneNumberFormat('+960 765 4321');
      expect(result, null);
    });

    test('WB-PHONE-017: Should trim whitespace before validation', () {
      final result = MagicValidator.validatePhoneNumberFormat('  7654321  ');
      expect(result, null);
    });
  });
}