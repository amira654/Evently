import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/core/resources/constant_manager.dart';

import 'category_DM.dart';

class EventDM {
  String id;
  final CategoryDM category;
  final String title;
  final String description;
  final DateTime dateTime;
  final int? lat;
  final int? lng;

  EventDM(
      {this.id = "",
      required this.category,
      required this.title,
      required this.description,
      required this.dateTime,
      this.lat,
      this.lng});

  EventDM.fromJson(Map<String, dynamic> json)
      : this(
            id: json["id"],
            title: json["title"],
            description: json["description"],
            dateTime: (json["dateTime"] as Timestamp).toDate(),
            category: ConstantManager.categoriesWithoutAll
                .firstWhere((category) => category.id == json["categoryId"]));

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "categoryId": category.id,
        "dateTime": Timestamp.fromDate(dateTime),
      };
}
