import 'package:evently_app/data/firebase_service/firebase_service.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_event.dart';
import '../../../../data/DM/event_DM.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  late TextEditingController searchController;
  List<EventDM> filteredEvents = [];
  List<EventDM> favEvents = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFavEvents();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              style: const TextStyle(color: Colors.black),
              onChanged: (searchKey) {
                filterFavEventsBySearchKey(searchKey);
              },
            ),
            Expanded(
                child: filteredEvents.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemBuilder: (context, index) => CustomEvent(
                            event: filteredEvents[index], favEvent: true),
                        itemCount: filteredEvents.length,
                      ))
          ],
        ),
      ),
    );
  }

  void getFavEvents() async {
    favEvents = await FirebaseServices.getFavEvents();
    filteredEvents = favEvents;
    setState(() {});
  }

  void filterFavEventsBySearchKey(String searchKey) {
    if (searchKey.trim().isEmpty) {
      filteredEvents = favEvents;
    } else {
      filteredEvents = favEvents
          .where(
            (event) =>
                event.title
                    .toLowerCase()
                    .contains(searchKey.toLowerCase().trim()) ||
                event.description
                    .toLowerCase()
                    .contains(searchKey.toLowerCase().trim()),
          )
          .toList();
    }

    setState(() {});
  }
}