import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class ConfigProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;
  String currentLang = "en";

  bool get isDark => currentTheme == ThemeMode.dark;

  bool get isEnglish => currentLang == "en";

  void changeAppTheme(ThemeMode newTheme) {
    if (currentTheme == newTheme) return;
    currentTheme = newTheme;
    notifyListeners();
  }

  void changeAppLang(String newLang) {
    if (currentLang == newLang) return;
    currentLang = newLang;
    notifyListeners();
  }


  Location location = Location();
  String locationMessage = 'check location';
  getLocation() async {
    bool isPermissionEnabled = await _checkPermission();
    if (!isPermissionEnabled) {
      locationMessage = 'check permission denied';
      notifyListeners();
      return;
    }

    bool isServiceEnabled = await _checkServiceEnabled();
    if (!isServiceEnabled) {
      locationMessage = 'check service locator denied';
      notifyListeners();
      return;
    }
    var myLocation = await location.getLocation();

    goToLocation(LatLng(myLocation.latitude ?? 0, myLocation.longitude ?? 0));
  }

  Future<bool> _checkPermission() async {
    PermissionStatus permissionStatus = await location.hasPermission();

    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
    }

    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> _checkServiceEnabled() async {
    bool isServiceEnabled = await location.serviceEnabled();

    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
    }
    return isServiceEnabled;
  }

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
          target: LatLng(location.latitude, location.longitude),zoom: 9
        ),
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

  streamLocation() {
    location.onLocationChanged.listen((location) {
      goToLocation(LatLng(location.latitude ?? 0, location.longitude ?? 0));
    });
  }
}
