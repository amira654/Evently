import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/core/resources/constant_manager.dart';

import 'category_DM.dart';

class EventDM {
  String id;
  final CategoryDM category;
  final String title;
  final String description;
  final DateTime dateTime;
  final double? lat;
  final double? lng;
  final String? userId;

  EventDM(
      {this.id = "",
      required this.category,
      required this.title,
      required this.description,
      required this.dateTime,
      this.lat = 0.0,
      this.lng = 0.0,
      required this.userId,
      });

  EventDM.fromJson(Map<String, dynamic> json)
      : this(
            id: json["id"],
            title: json["title"],
            description: json["description"],
            dateTime: (json["dateTime"] as Timestamp).toDate(),
            lat: json["lat"] ?? 0.0,
            lng: json["lng"] ?? 0.0,
            userId: json["userId"],
            category: ConstantManager.categories
                .firstWhere((category) => category.id == json["categoryId"]));

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "categoryId": category.id,
        "dateTime": Timestamp.fromDate(dateTime),
        "lat":lat,
        "lng":lng,
        "userId":userId
      };
}
