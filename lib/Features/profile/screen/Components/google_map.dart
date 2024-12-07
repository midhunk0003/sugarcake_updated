import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/gestures.dart';
import 'package:sugar_cake/Features/profile/screen/Components/google_map.dart';

// import 'dart:async';
// import 'dart:ui' as ui;
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:flutter/gestures.dart';
// import 'package:sugar_cake/Features/profile/screen/Components/google_map.dart';

class DeliveryMapView extends StatefulWidget {
  final void Function(bool isInDeliveryArea, LatLng? location, String? address)?
      onLocationSelected;

  const DeliveryMapView({Key? key, this.onLocationSelected}) : super(key: key);

  @override
  State<DeliveryMapView> createState() => _DeliveryMapViewState();
}

class _DeliveryMapViewState extends State<DeliveryMapView> {
  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _searchController = TextEditingController();
  BitmapDescriptor markerBitmap = BitmapDescriptor.defaultMarker;
  LatLng initialLocation = LatLng(25.3463, 55.4209); // Center of Sharjah
  LatLng? currentLocation;
  LatLng? selectedLocation;
  bool isInDeliveryArea = false;
  String? selectedAddress;

  // Approximate polygon points for Sharjah's boundaries
  final List<LatLng> polygonPoints = const [
    LatLng(25.206201, 55.633844),
    LatLng(25.418709, 55.742687),
    LatLng(25.416881, 55.694284),
    LatLng(25.432550, 55.637489),
    LatLng(25.409866, 55.629648),
    LatLng(25.368617, 55.592919),
    LatLng(25.356168, 55.498611),
    LatLng(25.398420, 55.423289),
    LatLng(25.352371, 55.368973),
    LatLng(25.331366, 55.355480),
    LatLng(25.300770, 55.357681),
    LatLng(25.302545, 55.385936),
  ];

  @override
  void initState() {
    super.initState();
    addCustomMarker();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  Future<void> addCustomMarker() async {
    final ByteData byteData =
        await rootBundle.load("assets/icons/locationopin.png");
    final ui.Codec codec = await ui.instantiateImageCodec(
      byteData.buffer.asUint8List(),
      targetWidth: 50, // Set the width you want
      targetHeight: 50, // Set the height you want
    );
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ByteData? resizedImage =
        await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List resizedImageData = resizedImage!.buffer.asUint8List();

    setState(() {
      markerBitmap = BitmapDescriptor.fromBytes(resizedImageData);
    });
  }

  Future<void> _searchLocation(String query) async {
    if (query.isEmpty) return;

    try {
      // Geocode the query to get latitude and longitude
      List<Location> locations = await locationFromAddress(query);

      if (locations.isNotEmpty) {
        LatLng searchedLocation =
            LatLng(locations.first.latitude, locations.first.longitude);

        // Check if the location is in the polygon
        bool inPolygon = _isLocationInPolygon(searchedLocation);

        setState(() {
          selectedLocation = searchedLocation;
          isInDeliveryArea = inPolygon;
          selectedAddress = query;
        });

        // Move the map to the searched location
        final GoogleMapController? controller = await _controller.future;
        controller?.animateCamera(
          CameraUpdate.newLatLngZoom(
            searchedLocation,
            14.0, // Adjust zoom level for better visibility
          ),
        );

        // Notify parent widget
        if (widget.onLocationSelected != null) {
          widget.onLocationSelected!(
              isInDeliveryArea, selectedLocation, selectedAddress);
        }
      } else {
        // Handle case where no location is found
        setState(() {
          isInDeliveryArea = false;
          selectedAddress = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Location not found")),
        );
      }
    } catch (e) {
      // Handle errors (e.g., network issues or invalid input)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error searching location: $e")),
      );
    }
  }

  Future<void> _onMapTapped(LatLng position) async {
    String? address;
    if (_isLocationInPolygon(position)) {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      address =
          "${place.name},${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";

      setState(() {
        selectedLocation = position;
        isInDeliveryArea = true;
        selectedAddress = address;
      });
    } else {
      setState(() {
        selectedLocation = null;
        isInDeliveryArea = false;
        selectedAddress = null;
      });
    }

    // Callback to notify parent widget
    if (widget.onLocationSelected != null) {
      widget.onLocationSelected!(
          isInDeliveryArea, selectedLocation, selectedAddress);
    }
  }

  bool _isLocationInPolygon(LatLng point) {
    bool inside = false;
    for (int i = 0, j = polygonPoints.length - 1;
        i < polygonPoints.length;
        j = i++) {
      if (((polygonPoints[i].latitude > point.latitude) !=
              (polygonPoints[j].latitude > point.latitude)) &&
          (point.longitude <
              (polygonPoints[j].longitude - polygonPoints[i].longitude) *
                      (point.latitude - polygonPoints[i].latitude) /
                      (polygonPoints[j].latitude - polygonPoints[i].latitude) +
                  polygonPoints[i].longitude)) {
        inside = !inside;
      }
    }
    return inside;
  }

  // The rest of your methods remain unchanged

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Search location",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onSubmitted: _searchLocation,
          ),
        ),
        Flexible(
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: initialLocation,
              zoom: 10.0, // Adjust zoom level for better view of Sharjah
            ),
            onMapCreated: (controller) {
              _controller.complete(controller);
            },
            onTap: _onMapTapped,
            markers: selectedLocation != null
                ? {
                    Marker(
                      markerId: const MarkerId('1'),
                      position: selectedLocation!,
                      icon: markerBitmap,
                    )
                  }
                : {},
            polygons: {
              Polygon(
                polygonId: PolygonId("deliveryArea"),
                points: polygonPoints,
                strokeWidth: 2,
                fillColor: Color(0xFF006491).withOpacity(0.2),
              ),
            },
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
              Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer()),
            },
          ),
        ),
        AddressInfo(
          isInDeliveryArea: isInDeliveryArea,
          selectedLocation: selectedLocation,
          address: selectedAddress,
        ),
      ],
    );
  }
}

// import 'dart:async';
// import 'dart:ui' as ui;
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:flutter/gestures.dart';

// class DeliveryMapView extends StatefulWidget {
//   final void Function(bool isInDeliveryArea, LatLng? location, String? address)?
//       onLocationSelected;

//   const DeliveryMapView({Key? key, this.onLocationSelected}) : super(key: key);

//   @override
//   State<DeliveryMapView> createState() => _DeliveryMapViewState();
// }

// class _DeliveryMapViewState extends State<DeliveryMapView> {
//   final Completer<GoogleMapController> _controller = Completer();
//   BitmapDescriptor markerBitmap = BitmapDescriptor.defaultMarker;
//   LatLng initialLocation = LatLng(25.3463, 55.4209); // Center of Sharjah
//   LatLng? currentLocation;
//   LatLng? selectedLocation;
//   bool isInDeliveryArea = false;
//   String? selectedAddress;

//   // Approximate polygon points for Sharjah's boundaries
//   final List<LatLng> polygonPoints = const [
//     LatLng(25.206201, 55.633844),
//     LatLng(25.418709, 55.742687),
//     LatLng(25.416881, 55.694284),
//     LatLng(25.432550, 55.637489),
//     LatLng(25.409866, 55.629648),
//     LatLng(25.368617, 55.592919),
//     LatLng(25.356168, 55.498611),
//     LatLng(25.398420, 55.423289),
//     LatLng(25.352371, 55.368973),
//     LatLng(25.331366, 55.355480),
//     LatLng(25.300770, 55.357681),
//     LatLng(25.302545, 55.385936),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     addCustomMarker();
//     _getCurrentLocation();
//   }

//   Future<void> addCustomMarker() async {
//     final ByteData byteData =
//         await rootBundle.load("assets/icons/locationopin.png");
//     final ui.Codec codec = await ui.instantiateImageCodec(
//       byteData.buffer.asUint8List(),
//       targetWidth: 50, // Set the width you want
//       targetHeight: 50, // Set the height you want
//     );
//     final ui.FrameInfo frameInfo = await codec.getNextFrame();
//     final ByteData? resizedImage =
//         await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
//     final Uint8List resizedImageData = resizedImage!.buffer.asUint8List();

//     setState(() {
//       markerBitmap = BitmapDescriptor.fromBytes(resizedImageData);
//     });
//   }

//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Check if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }

//     // Check for location permissions
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return Future.error('Location permissions are permanently denied.');
//     }

//     // Get the current location
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );

//     setState(() {
//       currentLocation = LatLng(position.latitude, position.longitude);
//     });
//   }

//   Future<void> _onMapTapped(LatLng position) async {
//     String? address;
//     if (_isLocationInPolygon(position)) {
//       List<Placemark> placemarks =
//           await placemarkFromCoordinates(position.latitude, position.longitude);
//       Placemark place = placemarks[0];
//       address =
//           "${place.name},${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";

//       setState(() {
//         selectedLocation = position;
//         isInDeliveryArea = true;
//         selectedAddress = address;
//       });
//     } else {
//       setState(() {
//         selectedLocation = null;
//         isInDeliveryArea = false;
//         selectedAddress = null;
//       });
//     }

//     // Callback to notify parent widget
//     if (widget.onLocationSelected != null) {
//       widget.onLocationSelected!(
//           isInDeliveryArea, selectedLocation, selectedAddress);
//     }
//   }

//   bool _isLocationInPolygon(LatLng point) {
//     bool inside = false;
//     for (int i = 0, j = polygonPoints.length - 1;
//         i < polygonPoints.length;
//         j = i++) {
//       if (((polygonPoints[i].latitude > point.latitude) !=
//               (polygonPoints[j].latitude > point.latitude)) &&
//           (point.longitude <
//               (polygonPoints[j].longitude - polygonPoints[i].longitude) *
//                       (point.latitude - polygonPoints[i].latitude) /
//                       (polygonPoints[j].latitude - polygonPoints[i].latitude) +
//                   polygonPoints[i].longitude)) {
//         inside = !inside;
//       }
//     }
//     return inside;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Flexible(
//           child: GoogleMap(
//             initialCameraPosition: CameraPosition(
//               target: initialLocation,
//               zoom: 10.0, // Adjust zoom level for better view of Sharjah
//             ),
//             onMapCreated: (controller) {
//               _controller.complete(controller);
//             },
//             onTap: _onMapTapped,
//             markers: selectedLocation != null
//                 ? {
//                     Marker(
//                       markerId: const MarkerId('1'),
//                       position: selectedLocation!,
//                       icon: markerBitmap,
//                     )
//                   }
//                 : {},
//             polygons: {
//               Polygon(
//                 polygonId: PolygonId("deliveryArea"),
//                 points: polygonPoints,
//                 strokeWidth: 2,
//                 fillColor: Color(0xFF006491).withOpacity(0.2),
//               ),
//             },
//             gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
//               Factory<OneSequenceGestureRecognizer>(
//                   () => EagerGestureRecognizer()),
//             },
//           ),
//         ),
//         AddressInfo(
//           isInDeliveryArea: isInDeliveryArea,
//           selectedLocation: selectedLocation,
//           address: selectedAddress,
//         ),
//       ],
//     );
//   }
// }

class AddressInfo extends StatelessWidget {
  final bool isInDeliveryArea;
  final LatLng? selectedLocation;
  final String? address;

  const AddressInfo({
    Key? key,
    required this.isInDeliveryArea,
    required this.selectedLocation,
    this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Text(
        isInDeliveryArea
            ? selectedLocation != null
                ? 'Selected Location: ${selectedLocation!.latitude}, ${selectedLocation!.longitude}\nAddress: $address'
                : 'Select a location'
            : 'Please select a delivery location within Sharjah area',
        style: TextStyle(
          fontSize: 16,
          color: isInDeliveryArea ? Colors.black : Colors.red,
        ),
      ),
    );
  }
}
