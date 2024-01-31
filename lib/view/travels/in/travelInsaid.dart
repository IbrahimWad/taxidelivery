// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxidelivery/Core/controller/in_Travel_Controller.dart';
import 'package:taxidelivery/view/widget/constant/COLOR.dart';
import 'package:taxidelivery/view/widget/customText.dart';
import 'package:taxidelivery/view/widget/customeButton.dart';
import 'package:taxidelivery/view/widget/searchform.dart';

class TravelInsaid extends StatelessWidget {
  const TravelInsaid({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InTravelController>(builder: (controller) {
      return Scaffold(
        // floatingActionButton: Container(
        //     height: 50,
        //     width: 180,
        //     child: CustomButton(text: 'سافر الان', onPressed: () {})),
        body: Stack(
          children: [
            GoogleMap(
              mapToolbarEnabled: false,
              markers: controller.markerss.values.toSet(),
              onTap: (argument) {
                controller.onMapTap(argument);
              },
              //mapType: MapType.terrain,
              onMapCreated: controller.onMapCreated,
              initialCameraPosition: CameraPosition(
                target: controller.center.value, zoom: 15,
                // zoom: 15,
              ),
            ),
            Positioned(
                top: 50,
                left: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    Get.dialog(
                      barrierDismissible: true,
                      SearchForm(
                          controller: controller.search,
                          suggestions: (String pattern) async {
                            return await controller.suggestion(
                                context, pattern);
                          },
                          itemBuilder:
                              (BuildContext context, dynamic suggestion) {
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                  ),
                                  Expanded(
                                      child: CustomText(
                                    text: suggestion.description!,
                                    color: text1,
                                  ))
                                ],
                              ),
                            );
                          },
                          onSuggestionSelected: (suggestion) {
                            controller.onSuggestionSelected(suggestion);

                            // update();
                          }),
                    );
                  },
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: input, borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 25,
                          color: primry,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                            child: CustomText(
                                text: controller.search.value.text,
                                alignment: Alignment.centerLeft,
                                fontWeight: FontWeight.normal,
                                height: 2,
                                fontsize: 20)),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.search,
                          size: 25,
                          color: text1,
                        )
                      ],
                    ),
                  ),
                )),
            Positioned(
                left: 10,
                right: 50,
                bottom: 30,
                child: CustomButton(
                  onPressed: () {
                    controller.whereToGo(context);
                    // controller.currenLocation();
                  },
                  text: 'تاكيد وجهتك',
                ))
          ],
        ),
      );
    });
  }
}
