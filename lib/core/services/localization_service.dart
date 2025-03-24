import 'package:get/get.dart';
import 'package:maps_graduation_project/core/langs/ar.dart';
import 'package:maps_graduation_project/core/langs/en.dart';
import 'package:maps_graduation_project/core/langs/tr.dart';

class LocalizationService extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'ar_AR': ar,
        'tr_TR': tr,
      };
}
