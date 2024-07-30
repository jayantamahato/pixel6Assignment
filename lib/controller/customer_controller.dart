import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pp/view/screens/error/error_screen.dart';
import '../core/exports.dart';
import '../models/address_model.dart';
import '../models/customer_model.dart';
import '../models/pan_model.dart';
import '../models/pan_res_model.dart';
import '../models/postal_model.dart';
import '../models/postal_res_model.dart';

class CustomerController extends GetxController {
  //field controller
  final TextEditingController panInputController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstAddressLineController =
      TextEditingController();
  final TextEditingController secondAddressLineController =
      TextEditingController();
  final TextEditingController postalController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

  //database instance
  final DatabaseService _databaseService = Get.put(DatabaseService());
//API service instance to call apis
  final ApiService _apiService = ApiService();
  //variables
  RxBool isLoading = false.obs;
  RxList stateList = [].obs; //for state dropdown
  RxList cityList = [].obs; //for city dropdown
  late PanResponseModel panRes; //grab the response from pan validation API
  late PostalResModel postalRes; //grab the response from postal validation API
  RxList<CustomerModel> customerList = <CustomerModel>[].obs;
  Rx<CustomerModel> customer = CustomerModel(address: []).obs;
  RxList<AddressModel> address = <AddressModel>[].obs;

//get customers from local
  Future getCustomers() async {
    try {
      List? data = await _databaseService.getCustomers();
      if (data == null) {
        customerList.clear();
      } else {
        List<CustomerModel> tempList = [];
        for (var customer in data) {
          tempList.add(
            CustomerModel(
              email: customer.email,
              fullName: customer.fullName,
              panNumber: customer.panNumber,
              phone: customer.phone,
              address: customer.address,
            ),
          );
        }
        customerList.assignAll(tempList);
        Log.d(msg: customerList);
      }
    } catch (e) {
      Log.e(msg: '$e');
    }
  }

//delete customer
  Future<bool> deleteCustomer({required int index}) async {
    try {
      isLoading(true);
      customerList.removeAt(index);
      Log.w(msg: customerList.length);
      await _databaseService.setCustomers(customerList: customerList);

      return true;
    } catch (e) {
      Log.e(msg: '$e');
      Get.offAllNamed(ErrorScreen.routeName, arguments: {'msg': '$e'});
      return false;
    } finally {
      isLoading(false);
    }
  }

//save address
  bool saveAddress() {
    try {
      AddressModel tempAddress = AddressModel(
          addressLine1: firstAddressLineController.text,
          addressLine2: secondAddressLineController.text,
          city: cityController.text,
          postalCode: postalController.text,
          state: stateController.text);
      address.add(tempAddress);
      firstAddressLineController.clear();
      secondAddressLineController.clear();
      postalController.clear();
      cityController.clear();
      stateController.clear();
      cityList.clear();
      stateList.clear();
      Log.d(msg: customer.value.address.length);
      return true;
    } catch (e) {
      Log.e(msg: '$e');
      Get.offAllNamed(ErrorScreen.routeName, arguments: {'msg': '$e'});
      return false;
    }
  }

//save customer -Temporary
  saveCustomer() {
    customer.value = CustomerModel(
        fullName: fullNameController.text,
        panNumber: panInputController.text,
        email: emailController.text,
        phone: phoneController.text,
        address: []);
  }

//save all customer info to local DB

  Future<bool> saveCustomerInformation() async {
    try {
      customer.value.address.assignAll(address);

      customerList.add(customer.value);
      Log.w(msg: customerList);
      bool res =
          await _databaseService.setCustomers(customerList: customerList);
      return res;
    } catch (e) {
      Log.e(msg: '$e');
      Get.offAllNamed(ErrorScreen.routeName, arguments: {'msg': '$e'});
      return false;
    }
  }

//Update the customer info and save it to local DB
  Future<bool> updateCustomerInformation({required int index}) async {
    try {
      customer.value.address.assignAll(address);

      customerList.removeAt(index);
      customerList.add(customer.value);

      Log.w(msg: customerList);
      bool res =
          await _databaseService.setCustomers(customerList: customerList);
      return res;
    } catch (e) {
      Log.e(msg: '$e');
      Get.offAllNamed(ErrorScreen.routeName, arguments: {'msg': '$e'});
      return false;
    }
  }

//delete temp address
  void deleteAddressFromTemp({required int index}) {
    try {
      Log.d(msg: index);
      address.removeAt(index);
    } catch (e) {
      Log.e(msg: '$e');
    }
  }

// set values for update an address from address list

  void editTempAddress({required int index}) {
    firstAddressLineController.text = address[index].addressLine1 ?? '';
    secondAddressLineController.text = address[index].addressLine2 ?? '';
    postalController.text = address[index].postalCode ?? '';
    cityController.text = address[index].city ?? '';
    stateController.text = address[index].state ?? '';
    // cityList.add(City(id: 0, name: cityController.text));
    // stateList.add(City(id: 0, name: stateController.text));
  }

//set the updated address to address as address model
  void updateTempAddress({required int index}) {
    address.removeAt(index);
    saveAddress();
  }

//get pan validation
  Future<bool> panValidation({required PanModel pan}) async {
    try {
      isLoading(true);
      var data =
          await _apiService.request.post('/verify-pan.php', data: pan.toJson());
      panRes = PanResponseModel.fromJson(data.data);

      fullNameController.text = panRes.fullName ?? '';
      return true;
    } catch (e) {
      Log.e(msg: '$e');
      Get.offAllNamed(ErrorScreen.routeName, arguments: {'msg': '$e'});
      return false;
    } finally {
      isLoading(false);
    }
  }

//get zip validation
  Future postalValidation({required PostalModel postalBody}) async {
    try {
      var res = await _apiService.request
          .post('/get-postcode-details.php', data: postalBody.toJson());
      postalRes = PostalResModel.fromJson(res.data);
      cityController.text = postalRes.city?[0].name ?? '';
      stateController.text = postalRes.state?[0].name ?? '';
      stateList.assignAll(postalRes.state ?? []);
      cityList.assignAll(postalRes.city ?? []);
      Log.d(msg: stateList);
    } catch (e) {
      Log.e(msg: '$e');
      Get.offAllNamed(ErrorScreen.routeName, arguments: {'msg': '$e'});
    }
  }

  void editCustomer({required int index}) {
    try {
      customer.value = customerList[index];
      fullNameController.text = customer.value.fullName ?? '';
      phoneController.text = customer.value.phone ?? '';
      emailController.text = customer.value.email ?? '';
      panInputController.text = customer.value.panNumber ?? '';
      address.assignAll(customer.value.address);
      stateController.text = address[0].state ?? '';
      cityController.text = address[0].city ?? '';
      postalController.text = address[0].postalCode ?? '';
      firstAddressLineController.text = address[0].addressLine1 ?? '';
      secondAddressLineController.text = address[0].addressLine2 ?? '';
    } catch (e) {
      Log.e(msg: '$e');
      Get.offAllNamed(ErrorScreen.routeName, arguments: {'msg': '$e'});
    }
  }

  Future<bool> deleteCustomerAddress(
      {required int customerIndex, required int addressIndex}) async {
    if (customerList[customerIndex].address.length > 1) {
      customerList[customerIndex].address.removeAt(addressIndex);
      await _databaseService.setCustomers(customerList: customerList);
      await getCustomers();
      return true;
    }

    return false;
  }
}
