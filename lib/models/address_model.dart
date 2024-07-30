import 'package:hive/hive.dart';

part 'address_model.g.dart'; // This is the generated file for the type adapter

@HiveType(
    typeId:
        1) // Ensure typeId is unique and doesn't conflict with CustomerModel
class AddressModel extends HiveObject {
  @HiveField(0)
  String? addressLine1;

  @HiveField(1)
  String? addressLine2;

  @HiveField(2)
  String? city;

  @HiveField(3)
  String? state;

  @HiveField(4)
  String? postalCode;

  AddressModel({
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.postalCode,
  });
}
