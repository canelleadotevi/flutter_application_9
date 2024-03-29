
import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../data/models/imageData.dart';
import '../../../../data/services/api.dart';
import '../../details/DetailsScreen.dart';

//les éléments reçues de l'api.
class ListTab extends StatefulWidget {
  const ListTab({super.key});

  @override
  createState() => _ListTabState();
}
class _ListTabState extends State {
  List<ImageData> _data = <ImageData>[];
  bool _loading = true;

  _getData() async {
    var response = await API.getPhotos();
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      setState(() {
        //pour recuperer la liste des données 
        _data = list.map((model) => ImageData.fromJson(model)).toList();
        _loading = false;
      });
    } else {
      throw Exception('Erreur récupération des données');
    }
  }

  @override
  initState() {
    super.initState();
    _getData();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      // Loader
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView(children: _data.map((e) => MyListItem(e)).toList());
    }
  }
}

// La liste des éléments. Chaque élément possède un titre, un sous titre et une image.
// Au clique, on affiche le détail de l'élément.
class MyListItem extends StatelessWidget {
  const MyListItem(this.image, {Key? key}) : super(key: key);

  final ImageData image;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(image.thumbnailUrl),
      title: Text(image.title),
      subtitle: Text(image.url),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsScreen(image: image)));
      },
    );
  }
}
