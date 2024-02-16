import 'package:flutter/material.dart';
import '../../../data/models/imageData.dart';
import '../../widgets/ImageFromNetworkWithLoader.dart';

// Vue qui affiche les détails d'un élément
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, required this.image}) : super(key: key);
//Ici j'affiche la page détail 
  final ImageData image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          image.title,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ImageFromNetworkWithLoader(url: image.url, width: 300, height: 300),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(image.url),
                  ),
                );
              },
              child: const Text('Action'),
            ),
          ],
        ),
      ),
    );
  }
}
