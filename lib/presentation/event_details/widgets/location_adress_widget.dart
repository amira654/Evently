import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocode/geocode.dart';

class LocationAddressWidget extends StatefulWidget {
  const LocationAddressWidget({super.key, required this.lat, required this.lng});

  final double lat,lng;

  @override
  State<LocationAddressWidget> createState() => _LocationAddressWidgetState();
}

class _LocationAddressWidgetState extends State<LocationAddressWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _convertLocationToAddress();
  }
  String address = "picked address";
  void _convertLocationToAddress() async {

    GeoCode geoCoder = GeoCode();
   var response =await geoCoder.reverseGeocoding(
       latitude: widget.lat, longitude: widget.lng);

    setState(() {
      address ='${response.countryName}, ${response.city}';
    });
  }
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
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
              Icons.gps_fixed,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 8,
          ),

          Expanded(
            child: Text(
              address,
              style: theme.textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }


}
