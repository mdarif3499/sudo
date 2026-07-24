import 'package:get/get.dart';
import 'languages/english.dart';
import 'languages/spanish.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': english,
    'es_ES': spanish,
  };
}
