import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:delivery_practice01/common/const/data.dart';

class UtilsData {
  static String pathToUrl(String value) {
    return 'http://$ip$value';
  }

  static List<String> listPathsToUrl(List paths) {
    return paths.map((e) => pathToUrl(e)).toList();
  }

  static String valueToBase64(String value) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);

    return stringToBase64.encode(value);
  }

  static var f = NumberFormat('###,###,###');
}
