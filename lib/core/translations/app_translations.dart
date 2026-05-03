import 'package:get/get.dart';
import 'package:mini_wallet/core/translations/en_us.dart';
import 'package:mini_wallet/core/translations/km_kh.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {'en_US': enUS, 'km_KH': kmKH};
}
