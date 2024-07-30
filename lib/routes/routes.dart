import 'package:get/get.dart';

import '../view/screens/address/address.dart';
import '../view/screens/customer/customer.dart';
import '../view/screens/customerList/customer_list.dart';
import '../view/screens/error/error_screen.dart';
import '../view/screens/onBoarding/on_boarding.dart';

List<GetPage> appRoutes = [
  GetPage(
    transition: Transition.rightToLeft,
    name: CustomerScreen.routeName,
    page: () => const CustomerScreen(),
  ),
  GetPage(
    transition: Transition.rightToLeft,
    name: OnboardingScreen.routeName,
    page: () => const OnboardingScreen(),
  ),
  GetPage(
    transition: Transition.rightToLeft,
    name: CustomersScreen.routeName,
    page: () => const CustomersScreen(),
  ),
  GetPage(
    transition: Transition.rightToLeft,
    name: AddressScreen.routeName,
    page: () => const AddressScreen(),
  ),
  GetPage(
    transition: Transition.rightToLeft,
    name: ErrorScreen.routeName,
    page: () => const ErrorScreen(),
  ),
];
