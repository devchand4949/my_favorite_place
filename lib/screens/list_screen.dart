import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/screens/add_places.dart';
import 'package:favorite_places/widgets/list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListScreen extends ConsumerWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final userPlace = ref.watch(userPlaceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Yout Place'),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddPlaces()));
          },
              icon:Icon(Icons.add))
        ],
      ),
      body: ListWidget(places: userPlace)
    );
  }
}
