import 'dart:io';

import 'package:riverpod/riverpod.dart';
import 'package:favorite_places/models/place_model.dart';

class UserPlaceNotifier extends StateNotifier<List<PlaceModel>> {
  UserPlaceNotifier() : super(const []);

  void addPlace(String title, File image,PlaceLocation location) {
    final newPlace = PlaceModel(title: title,image:image,location: location);
    state = [newPlace, ...state];
  }
}

final userPlaceProvider =
    StateNotifierProvider<UserPlaceNotifier, List<PlaceModel>>(
        (ref) => UserPlaceNotifier());
