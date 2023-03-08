// ignore_for_file: unused_import

import 'dart:convert';

class Azakar {
  String count;
  String description;
  String content;
  String reference;
  Azakar({
    required this.count,
    required this.description,
    required this.content,
    required this.reference,
  });
  factory Azakar.fromMap(Map<String, dynamic> json) => Azakar(
        count: json["count"],
        description: json["description"],
        content: json["content"],
        reference: json["reference"],
      );
}
