import 'package:favorite_places/models/place_model.dart';
import 'package:favorite_places/screens/detail_places.dart';
import 'package:flutter/material.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({super.key, required this.places});

  final List<PlaceModel> places;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Text('No places add yet!',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onSurface)),
      );
    }

    return ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              places[index].title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailPlaces(place: places[index])));
            },
          );
        });
  }
}
