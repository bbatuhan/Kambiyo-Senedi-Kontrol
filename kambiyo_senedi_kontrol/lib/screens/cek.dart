import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kambiyo_senedi_kontrol/controllers/cekcontroller.dart';

class Cek extends StatelessWidget {
  final controller = Get.put(CekController());

  @override
  Widget build(BuildContext context) {
    controller.start();
    return CekScreen();
  }
}

class CekScreen extends StatelessWidget {
  final controller = Get.put(CekController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Çek'),
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
                    "1. 'Çek' kelimesini ve eğer senet Türkçeden başka bir dille yazılmış ise o dilde 'Çek' karşılığı olarak kullanılan kelimeyi;",
                    'cek_kelimesi'),
                Divider(),
                Cerceve(
                    '2. Kayıtsız ve şartsız muayyen bir bedelin ödenmesi için havaleyi;',
                    'havale'),
                Divider(),
                Cerceve(" 3. Ödeyecek kimsenin 'muhatabın' ad ve soyadını;",
                    'muhatap_adi'),
                Divider(),
                Cerceve("4. Ödeme yerini;", 'odeme_yeri'),
                Divider(),
                Cerceve('5. Keşide gününü;', 'keside_gunu'),
                Divider(),
                Cerceve("Keşide yerini;", 'keside_yeri'),
                Divider(),
                Cerceve(
                    '6. Çeki çeken kimsenin (Keşidecinin) imzasını;', 'imza'),
                SizedBox(height: Get.height * 0.02),
                Row(
                  children: [
                    Spacer(),
                    RaisedButton(
                      color: Colors.green,
                      onPressed: () {
                        Get.dialog(AlertDialog(
                          title: Text('Düzenlenmiş Çek'),
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
                            "I - Unsurlar: \nMadde 692 – Çek:\n1. 'Çek' kelimesini ve eğer senet Türkçeden başka bir dille yazılmış ise o dilde 'Çek' karşılığı olarak kullanılan kelimeyi;\n2. Kayıtsız ve şartsız muayyen bir bedelin ödenmesi için havaleyi;\n3. Ödeyecek kimsenin 'muhatabın' ad ve soyadını;\n4. Ödeme yerini;\n5. Keşide gününü ve yerini;\n6. Çeki çeken kimsenin (Keşidecinin) imzasını;\nihtiva eder.\n II - Unsurların bulunmaması:\n Madde 693 – Yukarıki maddede gösterilen hususlardan birini ihtiva etmiyen bir senet aşağıdakifıkralarda yazılı haller dışında, çek sayılmaz.\n Çekte sarahat yoksa muhatabın ad ve soyadı yanında gösterilen yer, ödeme yeri sayılır. Muhatabın ad vesoyadı yanında birden fazla yer gösterildiği takdirde çek, ilk gösterilen yerde ödenir. Böyle bir sarahat ve başkabir kayıt da mevcut değilse çek muhatabın iş merkezinin bulunduğu yerde ödenir.\n Keşide yeri gösterilmemiş olan çek, keşidecinin ad ve soyadı yanında yazılı olan yerde çekilmiş sayılır.",
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 13),
                          )),
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
          border: Border.all(width: 0.4, color: Colors.grey[200]),
          color: Colors.grey[200],
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
  final controller = Get.put(CekController());
  final String sorgu;

  Oge(this.sorgu);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<CekController>(
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
  final controller = Get.put(CekController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<CekController>(
          builder: (_) => Row(
                children: [
                  ValueListenableBuilder(
                    valueListenable: Hive.box('bonobox').listenable(),
                    builder: (context, box, widget) {
                      if (controller.kutu.get('cek_kelimesi') &&
                          controller.kutu.get('havale') &&
                          controller.kutu.get('muhatap_adi') &&
                          controller.kutu.get('odeme_yeri') &&
                          controller.kutu.get('keside_gunu') &&
                          controller.kutu.get('keside_yeri') &&
                          controller.kutu.get('imza')) {
                        return Text('Geçerlidir.');
                      } else if (controller.kutu.get('cek_kelimesi') &&
                          controller.kutu.get('havale') &&
                          controller.kutu.get('muhatap_adi') &&
                          controller.kutu.get('odeme_yeri') == false &&
                          controller.kutu.get('keside_gunu') &&
                          controller.kutu.get('keside_yeri') &&
                          controller.kutu.get('imza')) {
                        return Expanded(
                          child: Text(
                            'Çekte sarahat yoksa muhatabın ad ve soyadı yanında gösterilen yer, ödeme yeri sayılır. Muhatabın ad vesoyadı yanında birden fazla yer gösterildiği takdirde çek, ilk gösterilen yerde ödenir. Böyle bir sarahat ve başka bir kayıt da mevcut değilse çek muhatabın iş merkezinin bulunduğu yerde ödenir.',
                            textAlign: TextAlign.justify,
                          ),
                        );
                      } else if (controller.kutu.get('cek_kelimesi') &&
                          controller.kutu.get('havale') &&
                          controller.kutu.get('muhatap_adi') &&
                          controller.kutu.get('odeme_yeri') &&
                          controller.kutu.get('keside_gunu') &&
                          controller.kutu.get('keside_yeri') == false &&
                          controller.kutu.get('imza')) {
                        return Expanded(
                          child: Text(
                            ' Keşide yeri gösterilmemiş olan çek, keşidecinin ad ve soyadı yanında yazılı olan yerde çekilmiş sayılır.',
                            textAlign: TextAlign.justify,
                          ),
                        );
                      } else if (controller.kutu.get('cek_kelimesi') &&
                          controller.kutu.get('havale') &&
                          controller.kutu.get('muhatap_adi') &&
                          controller.kutu.get('odeme_yeri') == false &&
                          controller.kutu.get('keside_gunu') &&
                          controller.kutu.get('keside_yeri') == false &&
                          controller.kutu.get('imza')) {
                        return Expanded(
                          child: Text(
                            '\tÇekte sarahat yoksa muhatabın ad ve soyadı yanında gösterilen yer, ödeme yeri sayılır. Muhatabın ad vesoyadı yanında birden fazla yer gösterildiği takdirde çek, ilk gösterilen yerde ödenir. Böyle bir sarahat ve başka bir kayıt da mevcut değilse çek muhatabın iş merkezinin bulunduğu yerde ödenir.\n\n\tKeşide yeri gösterilmemiş olan çek, keşidecinin ad ve soyadı yanında yazılı olan yerde çekilmiş sayılır.',
                            textAlign: TextAlign.justify,
                          ),
                        );
                      } else {
                        return Text('Çek sayılmamaktadır.');
                      }
                    },
                  ),
                ],
              )),
    );
  }
}
