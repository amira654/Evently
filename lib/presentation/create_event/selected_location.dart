import 'package:evently_app/presentation/create_event/provider/select_location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class SelectedLocation extends StatelessWidget {
  const SelectedLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SelectedLocationProvider(),
      child: Consumer<SelectedLocationProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    onMapCreated: (controller) {
                      provider.mapController = controller;
                    },
                    onTap: (LatLng latLng) {
                      provider.changeSelectedLocation(latLng);
                      Navigator.pop(context, provider.selectedLocation);
                    },
                    markers: provider.markers,
                    initialCameraPosition: provider.initialCameraPosition,
                  ),
                ),
                Container(
                  padding: REdgeInsets.all(16),
                  alignment: Alignment.center,
                  width: double.infinity,
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Tap on Location To Select',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
