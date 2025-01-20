import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/screens/add_places.dart';
import 'package:favorite_places/widgets/list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListScreen extends ConsumerStatefulWidget {
  const ListScreen({super.key});

  @override
  ConsumerState<ListScreen> createState() {
    return _ListScreenState();
  }
}

class _ListScreenState extends ConsumerState<ListScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(userPlaceProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final userPlace = ref.watch(userPlaceProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Yout Place'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddPlaces()));
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
              future: _placesFuture,
              builder: (contaxt, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? const Center(
                          child: CircleAvatar(),
                        )
                      : ListWidget(places: userPlace)),
        ));
  }
}
