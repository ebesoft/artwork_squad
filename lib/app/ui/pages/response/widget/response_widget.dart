import 'package:artwork_squad/app/data/models/artwork_model.dart';
import 'package:artwork_squad/app/data/services/artwork_pool.dart';
import 'package:flutter/material.dart';

class ResponseScreen extends StatelessWidget {
  //final ThemeController controller;

  //const ResponseScreen({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ArtWorkPoolService service = ArtWorkPoolService();
    Future<List<ArtWorkModel>> futureArtworks = service.fecthData();
    return FutureBuilder<List<ArtWorkModel>>(
      future: futureArtworks,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final items = snapshot.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              ArtWorkModel artwork = items[index];
              return Card(
                child: Row(
                  children: [
                    Image.network(artwork.imageUrl),
                    const SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Titulo: ${artwork.title}"),
                          Text("Estilo: ${artwork.style}"),
                          Text("Departamento: ${artwork.department}"),
                          Text("Artista: ${artwork.artistTitle}"),
                          Text("Pais: ${artwork.placeOrigin}"),
                          Text("Dimensiones: ${artwork.dimensions}"),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text("Estoy aquí: ${snapshot.error}");
        }

        // By default, show a loading spinner.
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
