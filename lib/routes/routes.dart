import 'package:get/get.dart';
import 'package:pp/view/screens/address/address.dart';
import 'package:pp/view/screens/error/error_screen.dart';

import '../view/screens/customer/customer.dart';
import '../view/screens/customerList/customer_list.dart';
import '../view/screens/onBoarding/onBoarding.dart';

List<GetPage> appRoutes = [
  GetPage(name: CustomerScreen.routeName, page: () => const CustomerScreen()),
  GetPage(
      name: OnboardingScreen.routeName, page: () => const OnboardingScreen()),
  GetPage(name: CustomersScreen.routeName, page: () => CustomersScreen()),
  GetPage(
      transition: Transition.rightToLeft,
      name: AddressScreen.routeName,
      page: () => AddressScreen()),
  GetPage(
    transition: Transition.rightToLeft,
    name: ErrorScreen.routeName,
    page: () => const ErrorScreen(),
  ),
];
