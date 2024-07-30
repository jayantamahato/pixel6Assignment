import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import 'core/service/database_service.dart';
import 'core/theme/app_theme.dart';
import 'core/values/strings.dart';
import 'models/address_model.dart';
import 'models/customer_model.dart';
import 'routes/routes.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CustomerModelAdapter());
  Hive.registerAdapter(AddressModelAdapter());
  DatabaseService.box = await Hive.openBox(DatabaseService.boxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppString.appName,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      initialRoute: '/',
      getPages: appRoutes,
    );
  }
}
