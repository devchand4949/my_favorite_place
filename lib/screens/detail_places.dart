import 'package:favorite_places/models/place_model.dart';
import 'package:favorite_places/screens/map_screen.dart';
import 'package:flutter/material.dart';

class DetailPlaces extends StatelessWidget {
  const DetailPlaces({super.key, required this.place});

  final PlaceModel place;

  String get locationImage {
    final lat = place.location!.latitude;
    final lon = place.location!.longitude;
    // 2)google map static api get kari
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lon&zoom=16&size=600x300&maptype=roadmap &markers=color:red%7Clabel:A%7C$lat,$lon&key=YOUR_API_KEYxyz';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(place.title),
        ),
        body: Stack(
          children: [
            Image.file(
              place.image,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MapScreen(
                                    location: place.location,
                                    isSelecting: false,
                                  )));
                        },
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(locationImage),
                        )),
                    Container(
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.transparent, Colors.black54],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                      child: Text(
                        textAlign: TextAlign.center,
                        place.location.address,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                    )
                  ],
                ))
          ],
        ));
  }
}
