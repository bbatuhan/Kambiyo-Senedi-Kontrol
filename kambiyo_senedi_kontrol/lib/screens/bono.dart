import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kambiyo_senedi_kontrol/controllers/bonocontroller.dart';

class Bono extends StatelessWidget {
  final controller = Get.put(BonoController());

  @override
  Widget build(BuildContext context) {
    controller.start();
    return BonoScreen();
  }
}

class BonoScreen extends StatelessWidget {
  final controller = Get.put(BonoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Bono'),
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
                    "1. Senet metninde (Bono) veya (Emre muharrer senet) kelimesini ve senet Türkçe'den başka bir dilde yazılmışsa o dilde bono karşılığı olarak kullanılan kelimeyi;",
                    'bono'),
                Divider(),
                Cerceve(
                    '2. Kayıtsız ve şartsız muayyen bir bedeli ödemek vaadi;',
                    'vaad'),
                Divider(),
                Cerceve("3.Vade;", 'vade'),
                Divider(),
                Cerceve("4.Ödeme yeri;", 'yeri'),
                Divider(),
                Cerceve(
                    '5.Kime ve kimin emrine ödenecek ise onun ad ve soyadı;',
                    'adi'),
                Divider(),
                Cerceve("6. Senedin tanzim edildiği günü;", 'gun'),
                Divider(),
                Cerceve('Senedin tanzim edildiği yeri;', 'tanzim_yeri'),
                Divider(),
                Cerceve('7. Senedi tanzim edenin imzasını;', 'imza'),
                SizedBox(height: Get.height * 0.02),
                Row(
                  children: [
                    Spacer(),
                    RaisedButton(
                      color: Colors.green,
                      onPressed: () {
                        Get.dialog(AlertDialog(
                          title: Text('Düzenlenmiş bono'),
                          content: Sonuc(),
                        ));
                      },
                      splashColor: Colors.lightGreen,
                      child: Text(
                        'Kontrol Et',
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
                                "A) Unsurlar: \nMadde 688 – Bono veya emre muharrer senet: \n1. Senet metninde (Bono) veya (Emre muharrer senet) kelimesini ve senet Türkçe'den başka bir dilde yazılmışsa o dilde bono karşılığı olarak kullanılan kelimeyi;\n 2. Kayıtsız ve şartsız muayyen bir bedeli ödemek vaadini;\n 3. Vadeyi;\n 4. Ödeme yerini;\n 5. Kime ve kimin emrine ödenecek ise onun ad ve soyadını;\n 6. Senedin tanzim edildiği gün ve yeri;\n 7. Senedi tanzim edenin imzasını;\nihtiva eder.\n B) Noksanlar:\n Madde 689 – Aşağıdaki fıkralarda yazılı haller mahfuz kalmak üzere, bundan önceki maddedegösterilen unsurlardan birini ihtiva etmiyen bir senet bono sayılmaz.\n Vadesi gösterilmemiş olan bono, görüldüğünde ödenmesi şart olan bir bono sayılır.\n Sarahat bulunmadığı takdirde senedin tanzim edildiği yer, ödeme yeri ve aynı zamanda tanzim edeninikametgahı sayılır\n Tanzim edildiği yer gösterilmiyen bir bono, tanzim edenin ad ve soyadı yanında yazılı olan yerde tanzimedilmiş sayılır.",
                                textAlign: TextAlign.justify,
                                style: TextStyle(fontSize: 13)),
                          ),
                        ));
                      },
                      splashColor: Colors.lightGreen,
                      child: Text(
                        'Kanunu Gör',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Spacer()
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Cerceve extends StatelessWidget {
  final String madde;
  final String sorgu;
  Cerceve(this.madde, this.sorgu);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1),
      padding: const EdgeInsets.all(1.0),
      decoration: BoxDecoration(
          border: Border.all(width: 0.4, color: Colors.amberAccent),
          color: Colors.amberAccent,
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
              style: TextStyle(color: Colors.black),
            )),
            Oge(sorgu),
          ],
        ),
      ),
    );
  }
}

class Oge extends StatelessWidget {
  final controller = Get.put(BonoController());
  final String sorgu;

  Oge(this.sorgu);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<BonoController>(
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
  final controller = Get.put(BonoController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<BonoController>(
          builder: (_) => Row(
                children: [
                  ValueListenableBuilder(
                    valueListenable: Hive.box('bonobox').listenable(),
                    builder: (context, box, widget) {
                      if (controller.kutu.get('bono') &&
                          controller.kutu.get('vaad') &&
                          controller.kutu.get('vade') &&
                          controller.kutu.get('yeri') &&
                          controller.kutu.get('adi') &&
                          controller.kutu.get('gun') &&
                          controller.kutu.get('tanzim_yeri') &&
                          controller.kutu.get('imza')) {
                        return Text('Geçerlidir.');
                      } else if (controller.kutu.get('bono') &&
                          controller.kutu.get('vaad') &&
                          controller.kutu.get('vade') == false &&
                          controller.kutu.get('yeri') &&
                          controller.kutu.get('adi') &&
                          controller.kutu.get('gun') &&
                          controller.kutu.get('tanzim_yeri') &&
                          controller.kutu.get('imza')) {
                        return Expanded(
                          child: Text(
                            '\tVadesi gösterilmemiş olan bono, görüldüğünde ödenmesi şart olan bir bono sayılır.\n',
                            textAlign: TextAlign.justify,
                          ),
                        );
                      } else if (controller.kutu.get('bono') &&
                          controller.kutu.get('vaad') &&
                          controller.kutu.get('vade') &&
                          controller.kutu.get('yeri') &&
                          controller.kutu.get('adi') &&
                          controller.kutu.get('gun') &&
                          controller.kutu.get('tanzim_yeri') == false &&
                          controller.kutu.get('imza')) {
                        return Expanded(
                          child: Text(
                            '\tTanzim edildiği yer gösterilmiyen bir bono, tanzim edenin ad ve soyadı yanında yazılı olan yerde tanzim edilmiş sayılır.',
                            textAlign: TextAlign.justify,
                          ),
                        );
                      } else if (controller.kutu.get('vaad') &&
                          controller.kutu.get('vade') == false &&
                          controller.kutu.get('yeri') &&
                          controller.kutu.get('adi') &&
                          controller.kutu.get('gun') &&
                          controller.kutu.get('tanzim_yeri') == false &&
                          controller.kutu.get('imza')) {
                        return Expanded(
                          child: Text(
                            '\tTanzim edildiği yer gösterilmiyen bir bono, tanzim edenin ad ve soyadı yanında yazılı olan yerde tanzim edilmiş sayılır. \n \nVadesi gösterilmemiş olan bono, görüldüğünde ödenmesi şart olan bir bono sayılır.',
                            textAlign: TextAlign.justify,
                          ),
                        );
                      } else {
                        return Text('Bono Sayılmamaktadır.');
                      }
                    },
                  ),
                ],
              )),
    );
  }
}
