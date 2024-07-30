import 'package:hive/hive.dart';

import 'address_model.dart';

part 'customer_model.g.dart'; // This is the generated file for the type adapter

@HiveType(typeId: 0) // Ensure typeId is unique for each model
class CustomerModel extends HiveObject {
  @HiveField(0)
  String? fullName;

  @HiveField(1)
  String? panNumber;

  @HiveField(2)
  String? email;

  @HiveField(3)
  String? phone;

  @HiveField(4)
  List<AddressModel> address;

  CustomerModel({
    this.fullName,
    this.panNumber,
    this.phone,
    this.email,
    required this.address,
  });
}
