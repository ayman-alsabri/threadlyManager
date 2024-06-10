import 'package:get/get.dart';
import 'translations.dart';

class Texts extends Translations{
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': EnUS.map,
    'ar_EG': ArYE.map,

  };

}