import 'dart:convert';

import 'package:html/parser.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/model/selected_item_model.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String removeAllHtmlTags() {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return replaceAll(exp, '');
  }

  static dynamic discountToPercent(double unit, double promo) {
    double percent = 0;
    double dis = unit - promo;
    percent = dis * 100 / unit;
    return percent.toStringAsFixed(1);
  }
}

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}

dynamic objToJson(List<SelectedItemModel> data) {
  List jsonArray = [];
  for (var e in data) {
    jsonArray.add(e.id ?? '');
  }
  return jsonEncode(jsonArray);
}

Future<bool> makeCall(String phone) => launch("tel://$phone");
