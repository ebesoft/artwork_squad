import 'package:artwork_squad/app/controllers/firestore_controller.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ListaEstados extends StatefulWidget {
  ListaEstados({required this.title});
  final String title;

  @override
  _ListaEstadosState createState() => _ListaEstadosState();
}

class _ListaEstadosState extends State<ListaEstados> {
  FirestoreController controlestados = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listas Estados'),
        actions: [
          IconButton(
              tooltip: 'Adicionar Estado',
              icon: Icon(Icons.add),
              onPressed: () {})
        ],
      ),

      body: getInfo(context, controlestados.readItems()),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            getInfo(context, controlestados.readItems());
          });
        },
        tooltip: 'Refrescar',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

@override
Widget getInfo(BuildContext context, Stream<QuerySnapshot> cestados) {
  return StreamBuilder(
    stream: cestados,
    /*FirebaseFirestore.instance
        .collection('clientes')
        .snapshots(),*/ //En esta línea colocamos el el objeto Future que estará esperando una respuesta
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      print(snapshot.connectionState);
      switch (snapshot.connectionState) {

        //En este case estamos a la espera de la respuesta, mientras tanto mostraremos el loader
        case ConnectionState.waiting:
          return Center(child: CircularProgressIndicator());

        case ConnectionState.active:
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          // print(snapshot.data);
          return snapshot.data != null
              ? VistaEstados(estados: snapshot.data!.docs)
              : Text('Sin Datos');

        /*
             Text(
              snapshot.data != null ?'ID: ${snapshot.data['id']}\nTitle: ${snapshot.data['title']}' : 'Vuelve a intentar',
              style: TextStyle(color: Colors.black, fontSize: 20),);
            */

        default:
          return Text('Presiona el boton para recargar');
      }
    },
  );
}

class VistaEstados extends StatelessWidget {
  final List estados;

  const VistaEstados({required this.estados});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: estados.length == 0 ? 0 : estados.length,
        itemBuilder: (context, posicion) {
          print(estados[posicion].id);
          return Card(
            elevation: 2,
            child: Container(
              padding: const EdgeInsets.only(
                  top: 4.0, bottom: 16.0, left: 8.0, right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(estados[posicion]['']),
                      ),
                      const SizedBox(
                        width: 14.0,
                      ),
                      Expanded(
                        child: Text(
                          'Alexander Vacca ',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      SizedBox(
                        width: 48.0,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text('Contenido'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Text('Contenido'),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
