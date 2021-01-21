import 'package:get/get.dart';
import 'package:hive/hive.dart';

class CekController extends GetxController {
  var kutu = Hive.box('cekbox');

  void start() {
    if (kutu.get('cek_kelimesi') == null) {
      refresh();
    }
  }

  void refresh() async {
    await kutu.put('cek_kelimesi', false);
    await kutu.put('havale', false);
    await kutu.put('muhatap_adi', false);
    await kutu.put('odeme_yeri', false);
    await kutu.put('keside_gunu', false);
    await kutu.put('keside_yeri', false);
    await kutu.put('imza', false);
  }
}
