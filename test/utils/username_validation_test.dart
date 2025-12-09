import 'package:flutter_test/flutter_test.dart';
import 'package:magic_hardware/utils/validators/validation.dart';

void runUserNameValidationTests() {
  group('MagicValidator.validateUsername - White Box Tests', () {
    // Branch 1: Null/Empty Check
    test('WB-USER-001: Should return error when input is null', () {
      final result = MagicValidator.validateUsername(null);
      expect(result, 'Username is required.');
    });

    test('WB-USER-002: Should return error when input is empty', () {
      final result = MagicValidator.validateUsername('');
      expect(result, 'Username is required.');
    });

    test('WB-USER-003: Should return error when input is whitespace', () {
      final result = MagicValidator.validateUsername('   ');
      expect(result, 'Username is required.');
    });

    // Branch 2: Length Check
    test('WB-USER-004: Should accept username with minimum length (3)', () {
      final result = MagicValidator.validateUsername('abc');
      expect(result, null);
    });

    test('WB-USER-005: Should accept username with maximum length (20)', () {
      final result = MagicValidator.validateUsername('abcdefghijklmnopqrst');
      expect(result, null);
    });

    test('WB-USER-006: Should reject username shorter than 3 characters', () {
      final result = MagicValidator.validateUsername('ab');
      expect(result, 'Username must be between 3 and 20 characters.');
    });

    test('WB-USER-007: Should reject username longer than 20 characters', () {
      final result = MagicValidator.validateUsername('abcdefghijklmnopqrstu');
      expect(result, 'Username must be between 3 and 20 characters.');
    });

    // Branch 3: Character Pattern Check
    test('WB-USER-008: Should accept alphanumeric characters', () {
      final result = MagicValidator.validateUsername('user123');
      expect(result, null);
    });

    test('WB-USER-009: Should accept underscore character', () {
      final result = MagicValidator.validateUsername('user_name');
      expect(result, null);
    });

    test('WB-USER-010: Should accept hyphen character', () {
      final result = MagicValidator.validateUsername('user-name');
      expect(result, null);
    });

    test('WB-USER-011: Should reject special characters', () {
      final result = MagicValidator.validateUsername('user@name');
      expect(result, 'Username can only contain letters, numbers, _ and -');
    });

    test('WB-USER-012: Should reject spaces', () {
      final result = MagicValidator.validateUsername('user name');
      expect(result, 'Username can only contain letters, numbers, _ and -');
    });

    test('WB-USER-013: Should reject dots', () {
      final result = MagicValidator.validateUsername('user.name');
      expect(result, 'Username can only contain letters, numbers, _ and -');
    });

    // Branch 4: Start/End Character Check
    test('WB-USER-014: Should reject username starting with underscore', () {
      final result = MagicValidator.validateUsername('_username');
      expect(result, 'Username cannot start or end with _ or -');
    });

    test('WB-USER-015: Should reject username starting with hyphen', () {
      final result = MagicValidator.validateUsername('-username');
      expect(result, 'Username cannot start or end with _ or -');
    });

    test('WB-USER-016: Should reject username ending with underscore', () {
      final result = MagicValidator.validateUsername('username_');
      expect(result, 'Username cannot start or end with _ or -');
    });

    test('WB-USER-017: Should reject username ending with hyphen', () {
      final result = MagicValidator.validateUsername('username-');
      expect(result, 'Username cannot start or end with _ or -');
    });

    test('WB-USER-018: Should accept username with underscore/hyphen in middle', () {
      final result = MagicValidator.validateUsername('user_name-123');
      expect(result, null);
    });

    // Path Coverage: Complex valid cases
    test('WB-USER-019: Should accept complex valid username', () {
      final result = MagicValidator.validateUsername('user_123-name');
      expect(result, null);
    });

    test('WB-USER-020: Should handle trimmed whitespace correctly', () {
      final result = MagicValidator.validateUsername('  user123  ');
      expect(result, null);
    });

    test('WB-USER-021: Should reject multiple invalid conditions', () {
      final result = MagicValidator.validateUsername('_a');
      expect(result, isNotNull);
    });
  });
}