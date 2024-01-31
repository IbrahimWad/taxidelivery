import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:taxidelivery/Core/services/nameOfArea.dart';
import 'package:taxidelivery/view/post/sendOrder.dart';
import 'package:taxidelivery/view/widget/constant/COLOR.dart';
import 'package:taxidelivery/view/widget/constant/URL.dart';
import 'package:taxidelivery/view/widget/customeButton.dart';
import '../../main.dart';
import '../../view/widget/constant/cach.dart';
import '../services/location_services.dart';
import 'package:location/location.dart' as loc;

mixin TravelController on GetxController {
  final TextEditingController search = TextEditingController();
  double latitude = 36.34133128616117;
  double longitude = 43.60669534653425;
  Set<Marker> markers = {};

  final Placemark pickPlaceMark = Placemark();
  List<Prediction> predictionList = [];
  Map<MarkerId, Marker> markerss = {};

  final center = const LatLng(36.34133128616117, 43.60669534653425).obs;
  late GoogleMapController mapController;

  Future<List<Prediction>> searchLocation(
      BuildContext context, String text) async {
    if (text.isNotEmpty) {
      final response = await getLocationData(text);
      final data = jsonDecode(response.body.toString());
      if (data['status'] == 'OK') {
        predictionList = [];
        data['predictions'].forEach(
            (precision) => predictionList.add(Prediction.fromJson(precision)));
      }
    }
    return predictionList;
  }

  Future<List<Prediction>> suggestion(BuildContext context, pattern) async {
    return await searchLocation(context, pattern);
  }

  void updateCameraPosition(double latitude, double longitude) {
    final newCenter = LatLng(latitude, longitude);
    center.value = newCenter;

    final newPosition = CameraPosition(target: newCenter, zoom: 15);
    mapController.animateCamera(CameraUpdate.newCameraPosition(newPosition));
  }

  Future<void> onSuggestionSelected(Prediction suggestion) async {
    search.value = TextEditingValue(text: '${suggestion.description}');
    final query = suggestion.description;

    try {
      final locations = await locationFromAddress(query!);

      if (locations.isNotEmpty) {
        for (final location in locations) {
          latitude = location.latitude;
          longitude = location.longitude;
          const markerId = MarkerId('place_name');
          final updatedMarker = markerss[markerId]!
              .copyWith(positionParam: LatLng(latitude, longitude));
          updateCameraPosition(latitude, longitude);
          markerss[markerId] = updatedMarker;
        }
      }
    } catch (e) {
      print(e);
    }

    update();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    final marker = Marker(
      markerId: const MarkerId('place_name'),
      position: LatLng(latitude, longitude),
    );

    markerss[const MarkerId('place_name')] = marker;

    update();
  }

  Future<void> onMapTap(LatLng argument) async {
    const markerId = MarkerId('place_name');
    final updatedMarker = markerss[markerId]!.copyWith(positionParam: argument);

    markerss[markerId] = updatedMarker;
    updateCameraPosition(argument.latitude, argument.longitude);
    await AreaServices()
        .AreaServicesName(argument.latitude, argument.longitude);

    search.text = await AreaServices()
        .AreaServicesName(argument.latitude, argument.longitude);
    update();
  }

  double? lat;
  double? lang;
  Future<Object> getLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    loc.Location location =
        loc.Location(); //explicit reference to the Location class
    Future _checkGps() async {
      if (!await location.serviceEnabled()) {
        location.requestService();
      }
    }

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {}
    }
    if (permission == LocationPermission.deniedForever) {}
    final Position position = await Geolocator.getCurrentPosition();
    lang = position.longitude;
    lat = position.latitude;

    return await Geolocator.getCurrentPosition();
  }

  String? payment = '';

  void whereToGo(BuildContext context) async {
    box.read(phoneSave);
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          color: bgColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 15),
                SizedBox(
                  height: 50,
                  child: CustomButton(
                    text: 'VIP رحلة',
                    onPressed: () {
                      Get.back();
                      Get.to(SendOrder(
                        latitude: latitude,
                        longitude: longitude,
                        mylatitude: lat!,
                        mylongitude: lang!,
                        phone: box.read(phoneSave),
                        price: calculateDistance(),
                        url: inVip,
                        paymnet: payment!,
                      ));
                    },
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 50,
                  child: CustomButton(
                    text: 'رحلة عادية',
                    onPressed: () {
                      Get.back();
                      Get.to(SendOrder(
                        latitude: latitude,
                        longitude: longitude,
                        mylatitude: lat!,
                        mylongitude: lang!,
                        phone: box.read(phoneSave),
                        price: calculateDistance(),
                        url: inRegular,
                        paymnet: payment!,
                      ));
                    },
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
  }

  void whereToGoOut(BuildContext context) async {
    box.read(phoneSave);
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          color: bgColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 15),
                SizedBox(
                  height: 50,
                  child: CustomButton(
                    text: 'VIP رحلة',
                    onPressed: () {
                      Get.back();
                      Get.to(SendOrder(
                        latitude: latitude,
                        longitude: longitude,
                        mylatitude: lat!,
                        mylongitude: lang!,
                        phone: box.read(phoneSave),
                        price: calculateDistance(),
                        url: outVip,
                        paymnet: payment!,
                      ));
                    },
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 50,
                  child: CustomButton(
                    text: 'رحلة عادية',
                    onPressed: () {
                      Get.back();
                      Get.to(
                        SendOrder(
                          latitude: latitude,
                          longitude: longitude,
                          mylatitude: lat!,
                          mylongitude: lang!,
                          phone: box.read(phoneSave),
                          price: calculateDistance(),
                          url: outRegular,
                          paymnet: payment!,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void onInit() {
    search;
    getLocation();
    // calculateDistance();
    super.onInit();
  }

  @override
  void onClose() {
    search.dispose();
    super.onClose();
  }

  double calculateDistance() {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((latitude - lat!) * p) / 2 +
        c(latitude * p) * c(lat! * p) * (1 - c((longitude - lang!) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
