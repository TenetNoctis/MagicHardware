import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:magic_hardware/utils/formatters/formatter.dart';

/// Represents a user in the application.
class UserModel {
  /// The unique identifier for the user.
  final String id;

  /// The user's first name.
  String firstName;

  /// The user's last name.
  String lastName;

  /// The user's username.
  final String username;

  /// The user's email address.
  final String email;

  /// The user's phone number.
  String phoneNumber;

  /// The URL of the user's profile picture.
  String profilePicture;

  /// The user's gender.
  String gender;

  /// The user's date of birth.
  String dateOfBirth;

  /// Creates a [UserModel].
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    this.gender = '',
    this.dateOfBirth = '',
  });

  /// Helper function to get the full name.
  String get fullName => "$firstName $lastName";

  /// Helper function to format phone number.
  String get formattedPhoneNo => MagicFormatter.formatPhoneNumber(phoneNumber);

  /// Static function to split full name into first and last name.
  static List<String> nameParts(String fullName) => fullName.split(" ");

  /// Static function to generate a username from the full name.
  static String generateUsername(String fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername = "$firstName$lastName";
    String usernameWithPrefix = "magic_$camelCaseUsername";
    return usernameWithPrefix;
  }

  /// Static Function to create an empty user model.
  static UserModel empty() => UserModel(
    id: '',
    firstName: '',
    lastName: '',
    username: '',
    email: '',
    phoneNumber: '',
    profilePicture: '',
    gender: '',
    dateOfBirth: '',
  );

  /// Convert model to JSON structure for storing in Firebase
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Username': username,
      'Email': email,
      'PhoneNumber': formattedPhoneNo,
      'ProfilePicture': profilePicture,
      'Gender': gender,
      'DateOfBirth': dateOfBirth,
    };
  }

  /// Factory method to create a UserModel from a Firebase document snapshot.
  factory UserModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        username: data['Username'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
        gender: data['Gender'] ?? '',
        dateOfBirth: data['DateOfBirth'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }

  /// Creates a copy of this [UserModel] with the given fields replaced with the new values.
  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? phoneNumber,
    String? profilePicture,
    String? gender,
    String? dateOfBirth,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }
}
