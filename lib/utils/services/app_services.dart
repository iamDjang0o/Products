import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Services extends GetxService {
  Future<Services> init() async {
    await GetStorage.init();

    return Future.value(this);
  }
}
