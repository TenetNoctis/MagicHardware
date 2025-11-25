import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:magic_hardware/utils/formatters/formatter.dart';

class AddressModel {
  String id;
  final String addressName;
  final String phoneNumber;
  final String street;
  final String island;
  final String atoll;
  final String postalCode;
  final String? landmark;
  final DateTime? dateTime;
  bool selectedAddress;

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

  String get formattedPhoneNo => MagicFormatter.formatPhoneNumber(phoneNumber);

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

  @override
  String toString() {
    return '$street, $atoll $island, $postalCode';
  }
}
