import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screens/bono.dart';
import 'screens/cek.dart';
import 'screens/homepage.dart';
import 'screens/police.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('bonobox');
  await Hive.openBox('cekbox');
  await Hive.openBox('policebox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: 'home',
      getPages: [
        GetPage(
            name: 'home', transition: Transition.cupertino, page: () => Home()),
        GetPage(
            name: 'bono', transition: Transition.cupertino, page: () => Bono()),
        GetPage(
            name: 'cek', transition: Transition.cupertino, page: () => Cek()),
        GetPage(
            name: 'police',
            transition: Transition.cupertino,
            page: () => Police())
      ],
    );
  }
}
