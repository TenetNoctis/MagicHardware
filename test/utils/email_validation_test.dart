import 'package:flutter_test/flutter_test.dart';
import 'package:magic_hardware/utils/validators/validation.dart';

void runEmailValidationTests() {
  group('MagicValidator.validateEmail - White Box Tests', () {

    // Branch 1: Null/Empty Check
    test('WB-EMAIL-001: Should return error when email is null', () {
      final result = MagicValidator.validateEmail(null);
      expect(result, 'Email is required.');
    });

    test('WB-EMAIL-002: Should return error when email is empty', () {
      final result = MagicValidator.validateEmail('');
      expect(result, 'Email is required.');
    });

    test('WB-EMAIL-003: Should return error when email is whitespace', () {
      final result = MagicValidator.validateEmail('   ');
      expect(result, 'Email is required.');
    });

    // Branch 2: Regex Pattern Check
    test('WB-EMAIL-004: Should accept valid email format', () {
      final result = MagicValidator.validateEmail('test@example.com');
      expect(result, null);
    });

    test('WB-EMAIL-005: Should accept email with numbers', () {
      final result = MagicValidator.validateEmail('test123@example.com');
      expect(result, null);
    });

    test('WB-EMAIL-006: Should accept email with dots', () {
      final result = MagicValidator.validateEmail('test.user@example.com');
      expect(result, null);
    });

    test('WB-EMAIL-007: Should accept email with plus sign', () {
      final result = MagicValidator.validateEmail('test+user@example.com');
      expect(result, null);
    });

    test('WB-EMAIL-008: Should reject email without @', () {
      final result = MagicValidator.validateEmail('testexample.com');
      expect(result, 'Invalid email address.');
    });

    test('WB-EMAIL-009: Should reject email without domain', () {
      final result = MagicValidator.validateEmail('test@');
      expect(result, 'Invalid email address.');
    });

    test('WB-EMAIL-010: Should reject email without local part', () {
      final result = MagicValidator.validateEmail('@example.com');
      expect(result, 'Invalid email address.');
    });

    test('WB-EMAIL-011: Should reject email without TLD', () {
      final result = MagicValidator.validateEmail('test@example');
      expect(result, 'Invalid email address.');
    });

    // Branch 3: Consecutive Dots Check
    test('WB-EMAIL-012: Should reject email with consecutive dots', () {
      final result = MagicValidator.validateEmail('test..user@example.com');
      expect(result, 'Invalid email address.');
    });

    test('WB-EMAIL-013: Should accept email with non-consecutive dots', () {
      final result = MagicValidator.validateEmail('test.user.name@example.com');
      expect(result, null);
    });

    // Path Coverage: Edge cases
    test('WB-EMAIL-014: Should trim whitespace', () {
      final result = MagicValidator.validateEmail('  test@example.com  ');
      expect(result, null);
    });

    test('WB-EMAIL-015: Should accept subdomain', () {
      final result = MagicValidator.validateEmail('test@mail.example.com');
      expect(result, null);
    });

    test('WB-EMAIL-016: Should reject multiple @ signs', () {
      final result = MagicValidator.validateEmail('test@@example.com');
      expect(result, 'Invalid email address.');
    });
  });
}