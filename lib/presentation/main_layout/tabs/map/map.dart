import 'package:evently_app/data/DM/category_DM.dart';
import 'package:evently_app/presentation/main_layout/tabs/map/widgets/map_item_widget.dart';
import 'package:evently_app/providers/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../data/DM/event_DM.dart';
import '../../../../data/firebase_service/firebase_service.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  late ConfigProvider mainProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mainProvider = Provider.of<ConfigProvider>(context, listen: false);
    // mainProvider.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    mainProvider = Provider.of<ConfigProvider>(context);

    return Consumer<ConfigProvider>(
      builder: (context, provider, child) {
        return Stack(
          children: [
            GoogleMap(
              onMapCreated: (controller) {
                provider.mapController = controller;
              },
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              markers: provider.markers,
              initialCameraPosition: provider.initialCameraPosition,
            ),
            Positioned(
              bottom: 20,
              right: 0,
              left: 0,
              child: SizedBox(
                height: 110.h,
                child: StreamBuilder(
                  stream: FirebaseServices.getEventsRealTimeUpdates(
                    const CategoryDM(
                      id: "0",
                      icon: Icons.home,
                      categoryName: "All Events",
                    ),
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return const Text("error");
                    }
                    List<EventDM> events = snapshot.data ?? [];
                    return SizedBox(
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: REdgeInsets.symmetric(horizontal: 16),
                        itemCount: events.length,
                        itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              provider.goToLocation(LatLng(
                                  events[index].lat ?? 0.0,
                                  events[index].lng ?? 0.0));
                            },
                            child: MapItemWidget(eventDM: events[index])),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
