import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/data/DM/category_DM.dart';
import 'package:evently_app/data/DM/event_DM.dart';
import 'package:evently_app/data/DM/userDM.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  static Future<List<EventDM>> getFavEvents() async {
    CollectionReference<EventDM> eventsCollection = getEventCollection();

    QuerySnapshot<EventDM> favEventsSnapshot = await eventsCollection
        .where(FieldPath.documentId,
        whereIn: UserDM.currentUser!.favouriteEventsId)
        .get();
    List<EventDM> favEvents = favEventsSnapshot.docs
        .map(
          (docSnapshot) => docSnapshot.data(),
    )
        .toList();

    return favEvents;
  }

  static CollectionReference<UserDM> getUsersCollection() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference<UserDM> usersCollection =
        db.collection("Users").withConverter<UserDM>(
              fromFirestore: (snapshot, options) =>
                  UserDM.fromJson(snapshot.data()!),
              toFirestore: (user, _) => user.toJson(),
            );
    return usersCollection;
  }

  static Future<void> addUserToFireStore(UserDM user) {
    CollectionReference<UserDM> usersCollection = getUsersCollection();
    DocumentReference<UserDM> userDoc = usersCollection.doc(user.id);
    return userDoc.set(user);
  }

  static Future<UserDM> getUserFromFireStore(String uid) async {
    CollectionReference<UserDM> usersCollection = getUsersCollection();
    DocumentReference<UserDM> userDoc = usersCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDoc.get();
    UserDM user = documentSnapshot.data() as UserDM;
    return user;
  }

  static Future<void> signUp(String email, String password, String name) async {
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    UserDM user = UserDM(
        id: credential.user!.uid,
        name: name,
        email: email,
        favouriteEventsId: []);
    await addUserToFireStore(user);
  }

  static Future<void> signIn(String email, String password) async {
    UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    UserDM user = await getUserFromFireStore(credential.user!.uid);
    UserDM.currentUser = user;
    print("UserId When Login  : ${user.name}");
    print("UserId When Login  : ${user.email}");
    print("UserId When Login  : ${user.id}");
    print("UserId When Login  : ${user.favouriteEventsId}");
  }

  static Future<void> updateUser(UserDM currentUser) {
    CollectionReference<UserDM> usersCollection = getUsersCollection();
    DocumentReference<UserDM> userDoc = usersCollection.doc(currentUser.id);
    return userDoc.set(currentUser);
  }

  static Future<void> removeEventFromFav(String eventId) async {
    UserDM currentUser = UserDM.currentUser!;
    currentUser.favouriteEventsId.remove(eventId);
    await updateUser(currentUser);
  }

  static void addEventToFavourite(String eventId) async {
    UserDM currentUser = UserDM.currentUser!;
    currentUser.favouriteEventsId.add(eventId);
    await updateUser(currentUser);
  }


 static loginWithGoogle() async{
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if(googleUser == null) return;
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
   var userData = await FirebaseAuth.instance.signInWithCredential(credential);
    UserDM user = UserDM(
        id: userData.user!.uid,
        name: userData.user!.displayName!,
        email: userData.user!.email!,
        favouriteEventsId: []);
    await addUserToFireStore(user);


    UserDM userDM = await getUserFromFireStore(userData.user!.uid);
    UserDM.currentUser = userDM;
  }

 static Future<void> updateEvent(EventDM event) async {
    CollectionReference<EventDM> eventsCollection = getEventCollection();
    DocumentReference<EventDM> eventDoc = eventsCollection.doc(event.id);
    await eventDoc.update(event.toJson());
  }
  static Future<void> deleteEvent(String eventId) async {
    CollectionReference<EventDM> eventsCollection = getEventCollection();
    DocumentReference<EventDM> eventDoc = eventsCollection.doc(eventId);
    await eventDoc.delete();
  }

  static Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }

  static Future<void> resetPassword(String email) async {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

    }catch(e){
      print(e);
    }

  }
}
