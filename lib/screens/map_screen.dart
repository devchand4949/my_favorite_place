import 'package:favorite_places/models/place_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen(
      {super.key,
      this.location = const PlaceLocation(
          latitude: 32.422, longitude: -122.084, address: ''),
      this.isSelecting = false});

  final PlaceLocation location;
  final bool isSelecting;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isSelecting ? 'pick your location' : 'your location'),
        actions: [
          if (widget.isSelecting)
            IconButton(icon: Icon(Icons.save), onPressed: () {})
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.location.latitude, widget.location.longitude),
            zoom: 16),
        markers: {
          Marker(
              markerId: MarkerId('m1'),
              position:
                  LatLng(widget.location.latitude, widget.location.longitude))
        },
      ),
    );
  }
}
