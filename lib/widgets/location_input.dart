import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:favorite_places/models/place_model.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key,required this.onSelectLocation});

  final void Function(PlaceLocation location)onSelectLocation;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;// placeLocation use for model screen
  var _isGettingLocation = false;

  String get locationImage {
    if(_pickedLocation ==  null){
      return '';
    }
    final lat = _pickedLocation!.latitude;
    final lon = _pickedLocation!.longitude;
    // 2)google map static api get kari
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lon&zoom=16&size=600x300&maptype=roadmap &markers=color:red%7Clabel:A%7C$lat,$lon&key=YOUR_API_KEYxyz';
  }

  void _getCurrentLocation()async{
    Location location = new Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final lon = locationData.longitude;

    if(lat == null || lon == null){
      return;
    }
    // 1) google map api get kari
    final url = Uri.https('//maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lon&key=YOUR_API_KEYxyz');
    final response = await http.get(url);
    final resdata = json.decode(response.body);
    final address = resdata['results'][0]['formatted_address'];

    setState(() {
      _pickedLocation = PlaceLocation(latitude: lat, longitude: lon, address: address);
      _isGettingLocation = false;
    });

    widget.onSelectLocation(_pickedLocation!);
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No location chosen',
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onBackground),
    );

    if(_pickedLocation != null){
      previewContent = Image.network(locationImage,fit: BoxFit.cover,width: double.infinity,height: double.infinity,);
    }

    if(_isGettingLocation){
      previewContent = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
          ),
          child:previewContent
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              label: Text('get Current Location'),
              icon: Icon(Icons.location_on),
              onPressed: _getCurrentLocation,
            ),
            TextButton.icon(
              label: Text('Select on Map'),
              icon: Icon(Icons.map),
              onPressed: () {},
            )
          ],
        )
      ],
    );
  }
}
