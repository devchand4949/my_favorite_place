import 'package:favorite_places/main.dart';
import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaces extends ConsumerStatefulWidget {
  const AddPlaces({super.key});

  @override
  ConsumerState<AddPlaces> createState() => _AddPlacesState();
}

class _AddPlacesState extends ConsumerState<AddPlaces> {
  final _titleController = TextEditingController();

  void _savePlace() {
    final enteresTitle = _titleController.text;

    if (enteresTitle.isEmpty) {
      return;
    }
    ref.read(userPlaceProvider.notifier).addPlace(enteresTitle);

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
            ImageInput(),
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
