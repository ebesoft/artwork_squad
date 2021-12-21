import 'dart:math';

import 'package:artwork_squad/app/controllers/firestore_controller.dart';
import 'package:artwork_squad/app/controllers/location_controller.dart';
import 'package:artwork_squad/app/controllers/login_controller.dart';
import 'package:artwork_squad/app/ui/global_widget/bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  FirestoreController controlp = Get.find();
  LoginController controluser = Get.find();
  Controllerlocations controlubicacion = Get.find();
  FirestoreController controlguardarloc = Get.find();

  @override
  void initState() {
    super.initState();
    controlubicacion.obtenerubicacion();
    _initNotificaciones();
  }

  _initNotificaciones() async {
    final _plugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('location_gps');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _plugin.initialize(initializationSettings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new MyAppBar().getAppBar(context),
      body: Scaffold(
        // bottomNavigationBar: new MyAppBar().getAppBar(context),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            backgroundColor: Colors.red[50],
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: ListTile(
                      title: Obx(
                        () => Text(
                          'Latitud: ${controlubicacion.locationlat}      Longitud: ${controlubicacion.locationlo}',
                          textScaleFactor: 1.2,
                        ),
                      ),
                      subtitle: Text(controluser.name),
                      leading: IconButton(
                          onPressed: () async {
                            final url =
                                "https://www.google.es/maps?q=${controlubicacion.locationlat},${controlubicacion.locationlo}";
                            await launch(url);
                          },
                          icon: Icon(
                            Icons.my_location_outlined,
                            color: Colors.blueAccent,
                          )),
                      trailing: IconButton(
                          onPressed: () {
                            controlubicacion.obtenerubicacion();
                            var ubicacion = <String, dynamic>{
                              'lat': controlubicacion.locationlat,
                              'lo': controlubicacion.locationlo,
                              'name': controluser.name,
                              'uid': controluser.uidrf,
                            };
                            controlguardarloc.guardarubicacion(
                                ubicacion, controluser.uidrf);

                            displayNotification(
                                title: "Cerca de Mi :",
                                body:
                                    '${controlubicacion.cercanos} amigos cerca a mi ubicacion');
                          },
                          icon: Icon(
                            Icons.refresh_outlined,
                            color: Colors.blueAccent,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        body: Obx(() => getInfo(
            context,
            controlp.readLocations(),
            controluser.uidrf,
            controlubicacion.locationlat,
            controlubicacion.locationlo)),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controlubicacion.obtenerubicacion();
          },
          tooltip: 'Refrescar',
          child: FaIcon(
            FontAwesomeIcons.searchLocation,
            color: Colors.white,
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  displayNotification({required String title, required String body}) async {
    final _plugin = FlutterLocalNotificationsPlugin();
    print("doing test");
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await _plugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'It could be anything you pass',
    );
  }
}

@override
Widget getInfo(BuildContext context, Stream<QuerySnapshot> ct, String uid,
    String lat, String lo) {
  return StreamBuilder(
    stream: ct,
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
              ? VistaLocations(
                  locations: snapshot.data!.docs, uid: uid, lat: lat, lo: lo)
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

class VistaLocations extends StatelessWidget {
  final List locations;
  final String uid;
  final String lat;
  final String lo;
  const VistaLocations(
      {required this.locations,
      required this.uid,
      required this.lat,
      required this.lo});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> listacalculo = [];
    Controllerlocations controlubicacion = Get.find();

//*********Calculo de Distancias***********//

    double deg2rad(double deg) {
      return (deg * pi / 180.0);
    }

    double rad2deg(double rad) {
      return (rad * 180.0 / pi);
    }

    String distance(
        double lat1, double lon1, double lat2, double lon2, String unit) {
      double theta = lon1 - lon2;
      double dist = sin(deg2rad(lat1)) * sin(deg2rad(lat2)) +
          cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * cos(deg2rad(theta));
      dist = acos(dist);
      dist = rad2deg(dist);
      dist = dist * 60 * 1.1515;
      if (unit == 'K') {
        dist = dist * 1.609344;
      } else if (unit == 'N') {
        dist = dist * 0.8684;
      }
      return dist.toStringAsFixed(2);
    }

    //**********************************//

    for (int i = 0; i < locations.length; i++) {
      if (uid != locations[i]['uid']) {
        String distancia = distance(
            double.parse(lat),
            double.parse(lo),
            double.parse(locations[i]['lat']),
            double.parse(locations[i]['lo']),
            'M');

        var calc = <String, dynamic>{
          'name': locations[i]['name'],
          'lat': locations[i]['lat'],
          'lo': locations[i]['lo'],
          'Dist': distancia
        };

        listacalculo.add(calc);
      }
    }

    listacalculo.sort((a, b) {
      return a['Dist'].compareTo(b['Dist']);
    });
    controlubicacion.cercanos = listacalculo.length.toString();

    return ListView.builder(
        itemCount: listacalculo.length == 0 ? 0 : listacalculo.length,
        itemBuilder: (context, posicion) {
          //print(listacalculo[posicion].id);
          return ListTile(
            leading: IconButton(
              onPressed: () async {
                final url =
                    "https://www.google.es/maps?q=${listacalculo[posicion]['lat']},${listacalculo[posicion]['lo']}";
                await launch(url);
              },
              icon: Icon(
                Icons.near_me_outlined,
                color: Colors.blueAccent,
              ),
            ),
            title: Text(
                'Latitud:${listacalculo[posicion]['lat']}       Longitud: ${listacalculo[posicion]['lo']}'),
            subtitle: Text(listacalculo[posicion]['name']),
            trailing: Container(
              width: 60,
              height: 20,
              color: Colors.red[80],
              child: Text("${listacalculo[posicion]['Dist']}Km"),
            ),
          );
        });
  }
}
