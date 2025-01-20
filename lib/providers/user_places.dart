import 'dart:io';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:riverpod/riverpod.dart';
import 'package:favorite_places/models/place_model.dart';
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbpath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(path.join(dbpath, 'places.db'),
      onCreate: (db, version) {
    return db.execute(
        'CREATE TABLE  user_places(id TEXT PRIMARY KEY,title TEXT,image TEXT,lat REAL, lon REAL,address TEXT) ');
  }, version: 1);
  return db;
}

class UserPlaceNotifier extends StateNotifier<List<PlaceModel>> {
  UserPlaceNotifier() : super(const []);

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');
    final places = data
        .map((row) => PlaceModel(
            id: row['id'] as String,
            title: row['title'] as String,
            image: File(row['image'] as String),
            location: PlaceLocation(
                latitude: row['lat'] as double,
                longitude: row['lon'] as double,
                address: row['address'] as String)))
        .toList();
    state = places;
  }

  void addPlace(String title, File image, PlaceLocation location) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$filename');

    final newPlace =
        PlaceModel(title: title, image: copiedImage, location: location);

    final db = await _getDatabase();
    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image,
      'lat': newPlace.location.latitude,
      'lon': newPlace.location.longitude,
      'address': newPlace.location.address
    });
    state = [newPlace, ...state];
  }
}

final userPlaceProvider =
    StateNotifierProvider<UserPlaceNotifier, List<PlaceModel>>(
        (ref) => UserPlaceNotifier());
