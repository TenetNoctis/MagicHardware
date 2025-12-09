import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:magic_hardware/utils/formatters/formatter.dart';

/// Model class representing a user's address.
class AddressModel {
  /// The unique identifier for the address.
  String id;

  /// The name of the address.
  final String addressName;

  /// The phone number associated with the address.
  final String phoneNumber;

  /// The street name where the address is located.
  final String street;

  /// The island where the address is located.
  final String island;

  /// The atoll where the address is located.
  final String atoll;

  /// The postal code for the address.
  final String postalCode;

  /// An optional landmark for the address.
  final String? landmark;

  /// The date and time the address was created or last updated.
  final DateTime? dateTime;

  /// A flag indicating whether this is the selected or default address.
  bool selectedAddress;

  /// Creates an [AddressModel].
  AddressModel({
    required this.id,
    required this.addressName,
    required this.phoneNumber,
    required this.street,
    required this.island,
    required this.atoll,
    required this.postalCode,
    this.landmark,
    this.dateTime,
    this.selectedAddress = true,
  });

  /// Returns the phone number formatted according to the application's standards.
  String get formattedPhoneNo => MagicFormatter.formatPhoneNumber(phoneNumber);

  /// Creates an empty [AddressModel].
  static AddressModel empty() => AddressModel(
    id: '',
    addressName: '',
    phoneNumber: '',
    street: '',
    island: '',
    atoll: '',
    postalCode: '',
    landmark: '',
  );

  /// Converts the [AddressModel] to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Address Name': addressName,
      'Phone Number': phoneNumber,
      'Street': street,
      'Island': island,
      'Atoll': atoll,
      'Postal Code': postalCode,
      'Landmark': landmark,
      'DateTime': DateTime.now(),
      'Selected Address': selectedAddress,
    };
  }

  /// Creates an [AddressModel] from a map of data.
  factory AddressModel.fromMap(Map<String, dynamic> data) {
    return AddressModel(
      id: data['Id'] as String,
      addressName: data['Address Name'] as String,
      phoneNumber: data['Phone Number'] as String,
      street: data['Street'] as String,
      island: data['Island'] as String,
      atoll: data['Atoll'] as String,
      postalCode: data['Postal Code'] as String,
      landmark: data['Landmark'] as String?,
      selectedAddress: data['Selected Address'] as bool,
      dateTime: (data['DateTime'] as Timestamp).toDate(),
    );
  }

  /// Creates an [AddressModel] from a Firestore [DocumentSnapshot].
  factory AddressModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return AddressModel(
      id: snapshot.id,
      addressName: data['Address Name'] ?? '',
      phoneNumber: data['Phone Number'] ?? '',
      street: data['Street'] ?? '',
      island: data['Island'] ?? '',
      atoll: data['Atoll'] ?? '',
      postalCode: data['Postal Code'] ?? '',
      landmark: data['Landmark'] ?? '',
      dateTime: (data['DateTime'] as Timestamp).toDate(),
      selectedAddress: data['Selected Address'] as bool,
    );
  }

  /// Returns a string representation of the address.
  @override
  String toString() {
    return '$street, $atoll $island, $postalCode';
  }
}
