import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:luminous_key_task/Localization/language_constants.dart';
import '../../Utils/color_utils.dart';
import '../Widgets/custom_button.dart';
import '../Widgets/custom_inkwell.dart';
import '../Widgets/custom_text_field.dart';

class MapScreen extends StatefulWidget {
  final LatLng address;

  const MapScreen({Key? key, required this.address,})
      : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  final Completer<GoogleMapController> _controller = Completer();

  LatLng center = const LatLng(31.975644507907077, 35.8532511);
  CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(31.975644507907077, 35.8532511),
    zoom: 12.0,
  );
  final TextEditingController _addressTitleController = TextEditingController();
  final TextEditingController _cityController = TextEditingController(text: "Amman");
  final TextEditingController _neighborhoodController = TextEditingController();
  final TextEditingController _streetNameController = TextEditingController();
  final TextEditingController _buildingController = TextEditingController();
  double? latitude;

  double? longitude;

  final Set<Marker> _markers = {};

  bool showSheetLocation = false;



  @override
  void initState() {
    changeCameraPosition(widget.address.latitude,widget.address.longitude);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: size.height,
              child: GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                onTap: (latLng) async {
                  _markers.add(Marker(
                      markerId: const MarkerId('Address'),
                      position: latLng,
                      infoWindow: const InfoWindow(title: 'Address')));

                  latitude = latLng.latitude;
                  longitude = latLng.longitude;

                  getLocationAddressInformation(latitude!, longitude!);

                  setState(() {});
                },
                gestureRecognizers: {}..add(Factory<EagerGestureRecognizer>(
                        () => EagerGestureRecognizer())),
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                markers: _markers,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
            Padding(
                padding: EdgeInsetsDirectional.only(
                    top: size.height * 0.04, start: size.width * 0.015),
                child: CustomInkwell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.all(size.height * 0.008),
                    decoration: const BoxDecoration(
                        color: kPrimaryColor, shape: BoxShape.circle),
                    margin: EdgeInsets.symmetric(
                        horizontal: size.width * 0.05,
                        vertical: size.width > 700
                            ? size.height * 0.0025
                            : size.height * 0.012),
                    child: Icon(
                      Icons.arrow_back,
                      size: size.height * 0.022,
                      color: Colors.white,
                    ),
                  ),
                )),
            Positioned(
              bottom: size.height*0.04,
              right: size.width*0.25,
              left: size.width*0.25,
              child: CustomInkwell(
                onTap: (){
                  setState(() {
                    showSheetLocation = true;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width*0.05,
                    vertical: size.height*0.018
                  ),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(size.height*0.01)
                  ),
                  child: Center(
                    child: Text(
                      getTranslated(context, "add_location")!,
                      style: TextStyle(
                        fontSize: size.height*0.02,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if(showSheetLocation)
            DraggableScrollableSheet(
                maxChildSize: 0.75,
                minChildSize: 0.15,
                initialChildSize: 0.15,
                builder: (BuildContext context, ScrollController scrollController) {
                  return Container(
                    height: size.height * 0.61,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey[400]!),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: ListView(
                      padding: EdgeInsets.symmetric(vertical: size.height*0.02),
                      controller: scrollController,
                      children: [
                        Center(
                          child: Container(
                            height: size.height*0.007,
                            width: size.width*0.3,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(size.height*0.005)
                            ),
                          ),
                        ),
                        SizedBox(height: size.height*0.02,),
                        Center(
                          child: Text(
                            getTranslated(context, "Pick_your_location")!,
                            style: TextStyle(
                              fontSize: size.height*0.022,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: size.width * 0.058,
                              end: size.width * 0.058,
                              bottom: size.height * 0.02,
                              top: size.height * 0.04),
                          child: Column(children: [
                            Row(
                              children: [
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 2,
                                  children: [
                                    Text(
                                      getTranslated(context, "address_title")!,
                                      style: TextStyle(
                                          color: Colors.grey[900],
                                          fontSize: size.height * 0.0165),
                                    ),
                                    Text(
                                      "*",
                                      style: TextStyle(
                                          color: Colors.red[900],
                                          fontSize: size.height * 0.0165),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.01),
                            CustomTextField(
                              controller: _addressTitleController,
                              validator: (value) {
                                if (value!.toString().trim().isEmpty) {
                                  return getTranslated(context, "can_not_empty");
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: size.height * 0.015),
                            Row(
                              children: [
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 2,
                                  children: [
                                    Text(
                                      getTranslated(context, "city")!,
                                      style: TextStyle(
                                          color: Colors.grey[900],
                                          fontSize: size.height * 0.0165),
                                    ),
                                    Text(
                                      "*",
                                      style: TextStyle(
                                          color: Colors.red[900],
                                          fontSize: size.height * 0.0165),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.01),
                            CustomTextField(
                              controller: _cityController,
                              readOnly: true,
                              validator: (value) {
                                if (value!.toString().trim().isEmpty) {
                                  return getTranslated(context, "can_not_empty");
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: size.height * 0.015),
                            Row(
                              children: [
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 2,
                                  children: [
                                    Text(
                                      getTranslated(context, "neighborhood")!,
                                      style: TextStyle(
                                          color: Colors.grey[900],
                                          fontSize: size.height * 0.0165),
                                    ),
                                    Text(
                                      "*",
                                      style: TextStyle(
                                          color: Colors.red[900],
                                          fontSize: size.height * 0.0165),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.01),
                            CustomTextField(
                              controller: _neighborhoodController,
                              validator: (value) {
                                if (value!.toString().trim().isEmpty) {
                                  return getTranslated(context, "can_not_empty");
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: size.height * 0.015),
                            Row(
                              children: [
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 2,
                                  children: [
                                    Text(
                                      getTranslated(context, "street_name")!,
                                      style: TextStyle(
                                          color: Colors.grey[900],
                                          fontSize: size.height * 0.0165),
                                    ),
                                    Text(
                                      "*",
                                      style: TextStyle(
                                          color: Colors.red[900],
                                          fontSize: size.height * 0.0165),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.01),
                            CustomTextField(
                              controller: _streetNameController,
                              validator: (value) {
                                if (value!.toString().trim().isEmpty) {
                                  return getTranslated(context, "can_not_empty");
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: size.height * 0.015),
                            Row(
                              children: [
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 2,
                                  children: [
                                    Text(
                                      getTranslated(context, "building_number")!,
                                      style: TextStyle(
                                          color: Colors.grey[900],
                                          fontSize: size.height * 0.0165),
                                    ),
                                    Text(
                                      "*",
                                      style: TextStyle(
                                          color: Colors.red[900],
                                          fontSize: size.height * 0.0165),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.01),
                            CustomTextField(
                              controller: _buildingController,
                              digitOnly: true,
                              validator: (value) {
                                if (value!.toString().trim().isEmpty) {
                                  return getTranslated(context, "can_not_empty");
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: size.height * 0.045),
                            CustomButton(

                                label: getTranslated(context, "save")!,
                                fontSize: size.height*0.025,
                                onPressed: () {
                                })
                          ]),
                        ),
                      ],
                    ),
                  );
                })
          ],
        ));
  }

  Future<String> getLocationAddressInformation(
      double latitude, double longitude) async {
    latitude = latitude;
    longitude = longitude;

    List<Placemark> placemarks =
    await placemarkFromCoordinates(latitude, longitude);

    Placemark placeMark = placemarks[0];

    _neighborhoodController.text =
    placeMark.subLocality == null ? "" : placeMark.subLocality!;
    _streetNameController.text =
    placeMark.street == null ? "" : placeMark.street!;

    return "${placeMark.subLocality}, ${placeMark.subLocality}, ${placeMark.subLocality}, ${placeMark.street}";
  }

  void changeCameraPosition(latitude, longitude) async {

    final GoogleMapController controller = await _controller.future;
    Future.delayed(Duration(seconds: 1)).then((value) {
      controller.animateCamera(
          CameraUpdate.newCameraPosition(
              CameraPosition(zoom: 14.4746,
                  target: LatLng(latitude,longitude))));

      _markers.clear();

      _markers.add(Marker(
          markerId: const MarkerId('Address'),
          position: LatLng(latitude, longitude),
          infoWindow: const InfoWindow(title: 'Address')));

      setState(() {

      });

    });




  }

}
