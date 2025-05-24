import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/data/DM/category_DM.dart';
import 'package:evently_app/data/DM/event_DM.dart';

class FirebaseServices {
  static CollectionReference<EventDM> getEventCollection() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference<EventDM> eventsCollection = db
        .collection("events")
        .withConverter<EventDM>(
          fromFirestore: (snapshot, _) => EventDM.fromJson(snapshot.data()!),
          toFirestore: (event, _) => event.toJson(),
        );

    return eventsCollection;
  }

  static Future<void> addEventToFireStore(EventDM event) {
    CollectionReference<EventDM> eventsCollection = getEventCollection();

    DocumentReference<EventDM> document = eventsCollection.doc();
    event.id = document.id;
    return document.set(event);
  }

  static Future<List<EventDM>> getEventsOneTimeRead(CategoryDM category) async {
    CollectionReference<EventDM> eventCollection = getEventCollection();
    Query<EventDM> query = eventCollection.orderBy("dateTime");
    if (category.id != "0") {
      query = query.where("categoryId", isEqualTo: category.id);
    }
    QuerySnapshot<EventDM> querySnapshot = await query.get();
    List<EventDM> events = querySnapshot.docs.map((doc) => doc.data()).toList();
    return events;
  }

  static Stream<List<EventDM>> getEventsRealTimeUpdates(CategoryDM category) {
    CollectionReference<EventDM> eventsCollection = getEventCollection();
    Query<EventDM> query = eventsCollection.orderBy("dateTime");
    if (category.id != "0") {
      query = query.where("categoryId", isEqualTo: category.id);
    }
    return query.snapshots().map(
          (querySnapshot) => querySnapshot.docs
              .map((docSnapshot) => docSnapshot.data())
              .toList(),
        );
  }
}
