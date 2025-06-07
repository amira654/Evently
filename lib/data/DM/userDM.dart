class UserDM {
  static UserDM? currentUser;

  String id;
  String name;
  String email;
  List<String> favouriteEventsId;

  UserDM(
      {required this.id,
      required this.name,
      required this.email,
      required this.favouriteEventsId});

  UserDM.fromJson(Map<String, dynamic> json)
      : this(
            id: json["id"],
            name: json["name"],
            email: json["email"],
            favouriteEventsId: (json["favouriteEventsId"] as List<dynamic>)
                .map(
                  (e) => e.toString(),
                )
                .toList());

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "favouriteEventsId": favouriteEventsId,
      };
}
