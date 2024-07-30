import 'package:get/get.dart';

import '../../models/customer_model.dart';
import '../../view/screens/error/error_screen.dart';
import '../exports.dart';

class DatabaseService {
  static const String _boxKey = 'customers';
  static const String boxName = 'pixelSix';
  static late var box;

  //set customers
  Future<bool> setCustomers({required List<CustomerModel> customerList}) async {
    try {
      await box.delete(_boxKey);
      await box.put(_boxKey, customerList);
      return true;
    } catch (e) {
      Log.e(msg: '$e');
      Get.offAllNamed(ErrorScreen.routeName, arguments: {'msg': '$e'});
      return false;
    }
  }

  //get customers
  List? getCustomers() {
    try {
      var data = box.get(_boxKey);
      return data;
    } catch (e) {
      Log.e(msg: '$e');
      Get.offAllNamed(ErrorScreen.routeName, arguments: {'msg': '$e'});
      return [];
    }
  }
}
