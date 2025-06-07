import 'package:evently_app/core/extensions/date_extention.dart';
import 'package:evently_app/data/DM/event_DM.dart';
import 'package:evently_app/presentation/event_details/widgets/location_adress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/routes_manager/routes_manager.dart';
import '../../data/DM/userDM.dart';
import '../../data/firebase_service/firebase_service.dart';

class EventDetailsView extends StatelessWidget {
  const EventDetailsView({super.key, required this.event});
  final EventDM event;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Details"),
        actions:event.userId==UserDM.currentUser!.id? [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RoutesManager.createEvent,
                  arguments: event);
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
              onPressed: () async {
                await FirebaseServices.deleteEvent(event.id).then((value) {
                  Navigator.pop(context);
                });
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              )),
        ]: [],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  event.category.imagePath ?? "",
                  fit: BoxFit.cover,
                ),
              )),
          SizedBox(height: 10),
          Text(
            event.title,
            style:
                theme.textTheme.titleLarge?.copyWith(color: theme.primaryColor),
          ),
          SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(width: 1.5, color: theme.primaryColor),
                borderRadius: BorderRadius.circular(8.r)),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(8.r)),
                  child: Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.dateTime.toFormattedDate,
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      event.dateTime.getTime,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(color: Colors.black),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          LocationAddressWidget(
            lat: event.lat ?? 0.0,
            lng: event.lng ?? 0.0,
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1.5, color: theme.primaryColor),
                borderRadius: BorderRadius.circular(16.r)),
            height: 200.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: GoogleMap(
                rotateGesturesEnabled: false,
                scrollGesturesEnabled: false,
                tiltGesturesEnabled: false,
                zoomGesturesEnabled: false,
                markers: {
                  Marker(
                    markerId: const MarkerId("1"),
                    position: LatLng(event.lat ?? 0.0, event.lng ?? 0.0),
                  ),
                },
                initialCameraPosition: CameraPosition(
                    target: LatLng(event.lat ?? 0.0, event.lng ?? 0.0),
                    zoom: 15),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Description",
            style: theme.textTheme.titleLarge?.copyWith(color: Colors.black),
          ),
          SizedBox(height: 10),
          Text(
            event.description,
            style: theme.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
