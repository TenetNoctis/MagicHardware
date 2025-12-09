import 'package:flutter_test/flutter_test.dart';
import 'package:magic_hardware/utils/validators/validation.dart';

void runPasswordValidationTests() {
  group('MagicValidator.validatePassword - White Box Tests', () {

    // Branch 1: Null/Empty Check
    test('WB-PASS-001: Should return error when password is null', () {
      final result = MagicValidator.validatePassword(null);
      expect(result, 'Password is required.');
    });

    test('WB-PASS-002: Should return error when password is empty', () {
      final result = MagicValidator.validatePassword('');
      expect(result, 'Password is required.');
    });

    // Branch 2: Length Check
    test('WB-PASS-003: Should return error when password length < 6', () {
      final result = MagicValidator.validatePassword('Abc1!');
      expect(result, 'Password must be at least 6 characters long.');
    });

    test('WB-PASS-004: Should pass when password length = 6 (boundary)', () {
      final result = MagicValidator.validatePassword('Abc@12');
      expect(result, null);
    });

    test('WB-PASS-005: Should pass when password length > 6', () {
      final result = MagicValidator.validatePassword('Abc@123');
      expect(result, null);
    });

    // Branch 3: Uppercase Letter Check
    test('WB-PASS-006: Should return error when no uppercase letter', () {
      final result = MagicValidator.validatePassword('test@123');
      expect(result, 'Password must contain at least one uppercase letter.');
    });

    test('WB-PASS-007: Should pass with uppercase letter', () {
      final result = MagicValidator.validatePassword('Test@123');
      expect(result, null);
    });

    // Branch 4: Number Check
    test('WB-PASS-008: Should return error when no number', () {
      final result = MagicValidator.validatePassword('Test@abc');
      expect(result, 'Password must contain at least one number.');
    });

    test('WB-PASS-009: Should pass with number', () {
      final result = MagicValidator.validatePassword('Test@1bc');
      expect(result, null);
    });

    // Branch 5: Special Character Check
    test('WB-PASS-010: Should return error when no special character', () {
      final result = MagicValidator.validatePassword('Test1234');
      expect(result, 'Password must contain at least one special character.');
    });

    test('WB-PASS-011: Should pass with special character @', () {
      final result = MagicValidator.validatePassword('Test@123');
      expect(result, null);
    });

    test('WB-PASS-012: Should pass with special character !', () {
      final result = MagicValidator.validatePassword('Test!123');
      expect(result, null);
    });

    test('WB-PASS-013: Should pass with special character #', () {
      final result = MagicValidator.validatePassword('Test#123');
      expect(result, null);
    });

    // Branch 6: Common Password Check
    test('WB-PASS-014: Should return error for common password "password"', () {
      final result = MagicValidator.validatePassword('password');
      expect(result, 'This password is too common. Please choose a stronger one.');
    });

    test('WB-PASS-015: Should return error for common password "123456"', () {
      final result = MagicValidator.validatePassword('123456');
      expect(result, 'This password is too common. Please choose a stronger one.');
    });

    test('WB-PASS-016: Should return error for common password "qwerty"', () {
      final result = MagicValidator.validatePassword('qwerty');
      expect(result, 'This password is too common. Please choose a stronger one.');
    });

    test('WB-PASS-017: Should return error for common password "abc123"', () {
      final result = MagicValidator.validatePassword('abc123');
      expect(result, 'This password is too common. Please choose a stronger one.');
    });

    test('WB-PASS-018: Should handle case-insensitive common password check', () {
      final result = MagicValidator.validatePassword('PASSWORD');
      expect(result, 'This password is too common. Please choose a stronger one.');
    });

    // Branch 7: Valid Password (All Conditions Met)
    test('WB-PASS-019: Should return null for valid password', () {
      final result = MagicValidator.validatePassword('Test@123');
      expect(result, null);
    });

    test('WB-PASS-020: Should return null for complex valid password', () {
      final result = MagicValidator.validatePassword('MySecure@Pass2024!');
      expect(result, null);
    });

    // Path Coverage: Combined conditions
    test('WB-PASS-021: Should catch first failing condition (length)', () {
      final result = MagicValidator.validatePassword('Ab1!');
      expect(result, 'Password must be at least 6 characters long.');
    });

    test('WB-PASS-022: Should catch second failing condition (uppercase)', () {
      final result = MagicValidator.validatePassword('test@123');
      expect(result, 'Password must contain at least one uppercase letter.');
    });

    test('WB-PASS-023: Should catch third failing condition (number)', () {
      final result = MagicValidator.validatePassword('Test@abc');
      expect(result, 'Password must contain at least one number.');
    });
  });
}