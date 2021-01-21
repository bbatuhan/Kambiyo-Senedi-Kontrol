import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kambiyo_senedi_kontrol/controllers/policecontroller.dart';

class Police extends StatelessWidget {
  final controller = Get.put(PoliceController());

  @override
  Widget build(BuildContext context) {
    controller.start();
    return PoliceScreen();
  }
}

class PoliceScreen extends StatelessWidget {
  final controller = Get.put(PoliceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Police'),
          backgroundColor: Colors.blueGrey,
          elevation: 0,
          actions: [
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () => controller.refresh()),
          ]),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: Get.width * 0.9,
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Cerceve(
                    "1. Senet metninde 'Poliçe' kelimesini veya başka bir dilde poliçe karşılığı olarak kullanılan kelimeyi",
                    'police_kelimesi'),
                Divider(),
                Cerceve(
                    ' 2. Muayyen bir bedelin ödenmesi hususunda kayıtsız ve şartsız havaleyi;',
                    'havale'),
                Divider(),
                Cerceve(
                    " 3. Ödeyecek olan kimsenin (Muhatabın) ad ve soyadını;",
                    'muhatap_adi'),
                Divider(),
                Cerceve("4. Vadeyi;", 'vade'),
                Divider(),
                Cerceve("5. Ödeme yerini;", 'odeme_yeri'),
                Divider(),
                Cerceve(
                    '6. Kime veya kimin emrine ödenecek ise onun ad ve soyadını;',
                    'odenecek_adi'),
                Divider(),
                Cerceve("7. Keşide tarihini;", 'keside_tarihi'),
                Divider(),
                Cerceve("7. Keşide yerini;", "keside_yeri"),
                Divider(),
                Cerceve('8. Keşidecinin imzasını;', 'imza'),
                SizedBox(height: Get.height * 0.02),
                Row(
                  children: [
                    Spacer(),
                    RaisedButton(
                      color: Colors.green,
                      onPressed: () {
                        Get.dialog(AlertDialog(
                          title: Text('Düzenlenmiş Poliçe'),
                          content: Sonuc(),
                        ));
                      },
                      splashColor: Colors.lightGreen,
                      child: Text(
                        'Kontrol et',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Spacer(),
                    RaisedButton(
                      color: Colors.green,
                      onPressed: () {
                        Get.dialog(AlertDialog(
                          content: SingleChildScrollView(
                            child: Text(
                              'A) Şekil:\n I - Unsurları\n 1. Umumi olarak:\n Madde 583 – Poliçe:\n 1. Senet metninde "Poliçe" kelimesini ve eğer senet Türkçeden başka bir dille yazılmışsa o dilde poliçe karşılığı olarak kullanılan kelimeyi; \n2. Muayyen bir bedelin ödenmesi hususunda kayıtsız ve şartsız havaleyi; \n3. Ödiyecek olan kimsenin (Muhatabın) ad ve soyadını; \n4. Vadeyi; \n5. Ödeme yerini; \n6. Kime veya kimin emrine ödenecek ise onun ad ve soyadını;\n7. Keşide tarihi ve yerini; \n8. Keşidecinin imzasını;\nihtiva eder \n2. Unsurların bulunmaması: \nMadde 584 – Yukarki maddede yazılı hususlardan birini ihtiva etmiyen senet aşağıdaki fıkralarda yazılı haller dışında poliçe sayılmaz. \nVadesi gösterilmiyen poliçenin görüldüğünde ödenmesi meşrut sayılır.\nAyrıca tasrih edilmiş olmadıkça muhatabın soyadı yanında gösterilen yer, ödeme yeri ve aynı zamanda da muhatabın ikametgahı sayılır. \nKeşide yeri gösterilmiyen poliçe, keşidecinin soyadı yanında gösterilen yerde keşide edilmiş sayılır.',
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ));
                      },
                      splashColor: Colors.lightGreen,
                      child: Text(
                        'Kanunu gör',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Spacer()
                  ],
                ),
                SizedBox(height: Get.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Cerceve extends StatelessWidget {
  final controller = Get.put(PoliceController());
  final String madde;
  final String sorgu;
  Cerceve(this.madde, this.sorgu);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1),
      padding: const EdgeInsets.all(1.0),
      decoration: BoxDecoration(
          border: Border.all(width: 0.4, color: Colors.greenAccent),
          color: Colors.greenAccent[100],
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, 1), blurRadius: 6)
          ]),
      child: Container(
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.fromLTRB(19, 5, 3, 3),
        child: Row(
          children: [
            Expanded(
                child: Text(
              madde,
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.black,
              ),
            )),
            Oge(sorgu),
          ],
        ),
      ),
    );
  }
}

class Oge extends StatelessWidget {
  final controller = Get.put(PoliceController());
  final String sorgu;
  void kontrol(sorgu) {
    if (controller.kutu.get(sorgu)) {
      Text('içerir');
    } else {
      Text('içermez');
    }
  }

  Oge(this.sorgu);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<PoliceController>(
          builder: (_) => Row(
                children: [
                  ValueListenableBuilder(
                    valueListenable: controller.kutu.listenable(),
                    builder: (context, box, widget) {
                      return Center(
                        child: Row(children: [
                          Checkbox(
                            value: box.get('$sorgu',
                                defaultValue: controller.kutu.get(sorgu)),
                            onChanged: (val) {
                              box.put('$sorgu', val);
                            },
                          ),
                        ]),
                      );
                    },
                  ),
                ],
              )),
    );
  }
}

class Sonuc extends StatelessWidget {
  final controller = Get.put(PoliceController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<PoliceController>(
          builder: (_) => Row(
                children: [
                  ValueListenableBuilder(
                    valueListenable: Hive.box('bonobox').listenable(),
                    builder: (context, box, widget) {
                      if (controller.kutu.get('police_kelimesi') &&
                          controller.kutu.get('havale') &&
                          controller.kutu.get('muhatap_adi') &&
                          controller.kutu.get('vade') &&
                          controller.kutu.get('odeme_yeri') &&
                          controller.kutu.get('odenecek_adi') &&
                          controller.kutu.get('keside_tarihi') &&
                          controller.kutu.get('keside_yeri') &&
                          controller.kutu.get('imza')) {
                        return Text('Geçerlidir.');
                      } else if (controller.kutu.get('police_kelimesi') &&
                          controller.kutu.get('havale') &&
                          controller.kutu.get('muhatap_adi') &&
                          controller.kutu.get('vade') == false &&
                          controller.kutu.get('odeme_yeri') &&
                          controller.kutu.get('odenecek_adi') &&
                          controller.kutu.get('keside_tarihi') &&
                          controller.kutu.get('keside_yeri') &&
                          controller.kutu.get('imza')) {
                        return Expanded(
                          child: Text(
                            'Vadesi gösterilmiyen poliçenin görüldüğünde ödenmesi meşrut sayılır.',
                            textAlign: TextAlign.justify,
                          ),
                        );
                      } else if (controller.kutu.get('police_kelimesi') &&
                          controller.kutu.get('havale') &&
                          controller.kutu.get('muhatap_adi') &&
                          controller.kutu.get('vade') &&
                          controller.kutu.get('odeme_yeri') == false &&
                          controller.kutu.get('odenecek_adi') &&
                          controller.kutu.get('keside_tarihi') &&
                          controller.kutu.get('keside_yeri') &&
                          controller.kutu.get('imza')) {
                        return Expanded(
                          child: Text(
                            ' Tasrih edilmiş olmadıkça muhatabın soyadı yanında gösterilen yer, ödeme yeri ve aynı zamanda da muhatabın ikametgahı sayılır.',
                            textAlign: TextAlign.justify,
                          ),
                        );
                      } else if (controller.kutu.get('police_kelimesi') &&
                          controller.kutu.get('havale') &&
                          controller.kutu.get('muhatap_adi') &&
                          controller.kutu.get('vade') == false &&
                          controller.kutu.get('odeme_yeri') == false &&
                          controller.kutu.get('odenecek_adi') &&
                          controller.kutu.get('keside_tarihi') &&
                          controller.kutu.get('keside_yeri') &&
                          controller.kutu.get('imza')) {
                        return Expanded(
                          child: Text(
                            'Vadesi gösterilmiyen poliçenin görüldüğünde ödenmesi meşrut sayılır.' +
                                '\n Tasrih edilmiş olmadıkça muhatabın soyadı yanında gösterilen yer, ödeme yeri ve aynı zamanda da muhatabın ikametgahı sayılır.',
                            textAlign: TextAlign.justify,
                          ),
                        );
                      } else {
                        return Text('Poliçe sayılmamaktadır.');
                      }
                    },
                  ),
                ],
              )),
    );
  }
}
