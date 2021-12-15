import 'package:artwork_squad/app/controllers/location_controller.dart';
import 'package:artwork_squad/app/ui/pages/location/widgets/location_card.dart';
import 'package:artwork_squad/app/ui/global_widget/bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: unused_import

class LocationPage extends GetView<LocationController> {
  //final List locations;
  final items = List<String>.generate(8, (i) => "Item $i");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new MyAppBar().getAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LocationCard(
            title: 'MI UBICACIÓN',
            lat: 11.004556423794284,
            long: -74.7217010498047,
            onUpdate: () {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              'CERCA DE MÍ',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          // ListView on remaining screen space
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return LocationCard(
                  title: 'John Doe',
                  lat: 11.004556423794284,
                  long: -74.7217010498047,
                  distance: 25,
                  onUpdate: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
