import 'package:favorite_places/models/place_model.dart';
import 'package:flutter/material.dart';

class DetailPlaces extends StatelessWidget {
  const DetailPlaces({super.key,required this.place});

  final PlaceModel place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(place.title),),
      body: Center(
        child: Text(place.title,
        style: TextTheme.of(context)
            .titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.surface)
          ,),
      ),
    );
  }
}
