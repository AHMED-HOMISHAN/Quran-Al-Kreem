// ignore_for_file: unused_import

import 'dart:convert';

class Surah {
  int id;
  String revelationPlace;
  int revelationOrder;
  String name;
  String arabicName;
  int versesCount;
  List pageNo;
  Surah({
    required this.arabicName,
    required this.id,
    required this.name,
    required this.revelationOrder,
    required this.revelationPlace,
    required this.versesCount,
    required this.pageNo,
  });
  factory Surah.fromMap(Map<String, dynamic> json) => Surah(
        arabicName: json["name_arabic"],
        id: json["id"],
        name: json["name_simple"],
        revelationOrder: json["revelation_order"],
        revelationPlace: json["revelation_place"],
        versesCount: json["verses_count"],
        pageNo: json["pages"],
      );
}
