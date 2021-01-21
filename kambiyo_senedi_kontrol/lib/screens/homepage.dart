import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.library_books),
              onPressed: () => Get.dialog(AboutDialog(
                  applicationName: 'Kambiyo Senedi Kontrolcüsü',
                  applicationIcon: Icon(Icons.library_books_outlined),
                  applicationVersion: '1.0',
                  applicationLegalese:
                      'Bu uygulama Batuhan Yılmaz tarafından geliştirilmiştir.'))),
          backgroundColor: Colors.blueGrey,
          elevation: 0,
          actions: [
            Builder(builder: (BuildContext context) {
              if (Get.isDarkMode == false) {
                return IconButton(
                    icon: Icon(Icons.nightlight_round),
                    onPressed: () => Get.changeTheme(
                        Get.isDarkMode ? ThemeData.light() : ThemeData.dark()));
              } else {
                return IconButton(
                    icon: Icon(Icons.wb_sunny),
                    onPressed: () => Get.changeTheme(
                        Get.isDarkMode ? ThemeData.light() : ThemeData.dark()));
              }
            })
          ],
        ),
        body: Center(
          child: Stack(
            children: [
              Image.asset('assets/theme.jpg'),
              Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  Container(
                    height: Get.height * 0.1,
                    width: Get.width * 0.4,
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 0.4, color: Colors.amberAccent),
                        color: Colors.amberAccent,
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 1),
                              blurRadius: 6)
                        ]),
                    child: FlatButton(
                      onPressed: () => Get.toNamed('bono'),
                      child: Text(
                        'Bono Kontrolü',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  Container(
                    height: Get.height * 0.1,
                    width: Get.width * 0.4,
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.4, color: Colors.grey[200]),
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 1),
                              blurRadius: 12)
                        ]),
                    child: FlatButton(
                      onPressed: () => Get.toNamed('cek'),
                      child: Text(
                        'Çek Kontrolü',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  Container(
                    height: Get.height * 0.1,
                    width: Get.width * 0.4,
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 0.4, color: Colors.greenAccent),
                        color: Colors.greenAccent[100],
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 1),
                              blurRadius: 12)
                        ]),
                    child: FlatButton(
                      onPressed: () => Get.toNamed('police'),
                      child: Text(
                        'Poliçe Kontrolü',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      '\tUyarı: Bu uygulama 12.01.2021 tarihinde güncellenmiş olup ilgili kanun ve düzenlemeler değişmiş olabilir.',
                      style: TextStyle(),
                      textAlign: TextAlign.justify,
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
