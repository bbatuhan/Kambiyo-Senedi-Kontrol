import 'package:get/get.dart';
import 'package:hive/hive.dart';

class PoliceController extends GetxController {
  var kutu = Hive.box('policebox');

  void start() {
    if (kutu.get('police_kelimesi') == null) {
      refresh();
    }
  }

  void refresh() async {
    await kutu.put('police_kelimesi', false);
    await kutu.put('havale', false);
    await kutu.put('muhatap_adi', false);
    await kutu.put('vade', false);
    await kutu.put('odeme_yeri', false);
    await kutu.put('odenecek_adi', false);
    await kutu.put('keside_tarihi', false);
    await kutu.put('keside_yeri', false);
    await kutu.put('imza', false);
  }
}
