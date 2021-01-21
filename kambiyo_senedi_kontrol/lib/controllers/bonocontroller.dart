import 'package:get/get.dart';
import 'package:hive/hive.dart';

class BonoController extends GetxController {
  var kutu = Hive.box('bonobox');

  void start() {
    if (kutu.get('bono') == null) {
      refresh();
    }
  }

  void refresh() async {
    await kutu.put('bono', false);
    await kutu.put('vaad', false);
    await kutu.put('vade', false);
    await kutu.put('yeri', false);
    await kutu.put('adi', false);
    await kutu.put('gun', false);
    await kutu.put('tanzim_yeri', false);
    await kutu.put('imza', false);
  }
}
