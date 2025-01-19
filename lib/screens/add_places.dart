import 'dart:io';

import 'package:favorite_places/main.dart';
import 'package:favorite_places/models/place_model.dart';
import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaces extends ConsumerStatefulWidget {
  const AddPlaces({super.key});

  @override
  ConsumerState<AddPlaces> createState() => _AddPlacesState();
}

class _AddPlacesState extends ConsumerState<AddPlaces> {
  final _titleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  void _savePlace() {
    final enteresTitle = _titleController.text;

    if (enteresTitle.isEmpty || _selectedImage == null || _selectedLocation == null) {
      return;
    }
    ref
        .read(userPlaceProvider.notifier)
    // provider mathi aavre che addPlace method
        .addPlace(enteresTitle, _selectedImage!,_selectedLocation!);

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add new places',
          style: TextTheme.of(context)
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.surface),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            // title input field
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
            const SizedBox(
              height: 10,
            ),
            // camera capture field
            ImageInput(
              onSelectedImageDataPass: (image) {
                _selectedImage = image;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            // // location input field
            LocationInput(onSelectLocation: (location){
              _selectedLocation = location;
            },),
            const SizedBox(
              height: 10,
            ),
            //submit button
            ElevatedButton.icon(
                onPressed: _savePlace,
                icon: Icon(Icons.camera_alt),
                label: Text(
                  'Add capture',
                ))
          ],
        ),
      ),
    );
  }
}
