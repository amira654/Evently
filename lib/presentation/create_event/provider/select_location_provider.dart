import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectedLocationProvider extends ChangeNotifier {
  CameraPosition initialCameraPosition = const CameraPosition(
      target: LatLng(37.43296265331129, -122.08832357078792),
      zoom: 19.151926040649414);

  Set<Marker> markers = {
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(37.43296265331129, -122.08832357078792),
      infoWindow: InfoWindow(title: 'myLocation'),
    )
  };

  late GoogleMapController mapController;

  goToLocation(LatLng location) {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(location.longitude, location.longitude), zoom: 9),
      ),
    );
    markers = {
      Marker(
        markerId: const MarkerId('1'),
        position: LatLng(location.latitude, location.longitude),
        infoWindow: const InfoWindow(title: 'myLocation'),
      )
    };
    notifyListeners();
  }

  LatLng? selectedLocation;

  changeSelectedLocation(LatLng location) {
    selectedLocation = location;
    goToLocation(location);
    notifyListeners();
  }
}
