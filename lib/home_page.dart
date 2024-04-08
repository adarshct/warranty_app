import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:warranty_app/controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final controller = Get.put(Controller());
  final modelControllerr = TextEditingController();
  final serielNumberController = TextEditingController();
  final suggestionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              SizedBox(
                height: 200,
              ),
              DottedBorder(
                child: TypeAheadField(
                  emptyBuilder: (context) => SizedBox(),
                  builder: (context, modelController, focusNode) {
                    // modelController.text = controller.modelName.value;
                    return TextField(
                      controller: modelController,
                      focusNode: focusNode,
                      onChanged: (value) async {
                        if (value.isNotEmpty) {
                          await controller.fetchProductModels(query: value);
                        } else {
                          controller.modelsList.clear();
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: "Search model...",
                      ),
                    );
                  },
                  itemBuilder: (context, value) {
                    return Text(value["model"]);
                  },
                  itemSeparatorBuilder: (context, index) =>
                      SizedBox(height: 10),
                  controller: modelControllerr,
                  onSelected: (value) async {
                    //controller.modelName.value = value["model"];
                    controller.modelReference.value = value["reference"];

                    modelControllerr.text = value["model"];

                    serielNumberController.clear();

                    await controller.fetchSerielNumbers();

                    controller.modelsList.clear();
                  },
                  suggestionsCallback: (search) {
                    return controller.modelsList;
                  },
                ),
                // child: Obx(
                //   () => TextField(
                //     controller: modelController,
                //     onChanged: (value) async {
                //       if (value.isNotEmpty) {
                //         await controller.fetchProductModels(query: value);
                //       } else {
                //         controller.modelsList.clear();
                //       }
                //     },
                //     decoration: InputDecoration(
                //       contentPadding: EdgeInsets.all(10),
                //       hintText: "Search model...",
                //       suffix: controller.modelsList.isEmpty
                //           ? SizedBox()
                //           : DropdownButton(
                //               iconDisabledColor: Colors.black,
                //               iconEnabledColor: Colors.black,
                //               iconSize: 30,
                //               items: controller.modelsList
                //                   .map(
                //                     (element) => DropdownMenuItem(
                //                       value: element,
                //                       child: SizedBox(
                //                         width: 180,
                //                         height: 20,
                //                         child: Text(
                //                           element["model"],
                //                         ),
                //                       ),
                //                     ),
                //                   )
                //                   .toList(),
                //               onChanged: (value) async {
                //                 modelController.text = value!["model"];
                //                 controller.modelReference.value =
                //                     value["reference"];

                //                 await controller.fetchSerielNumbers();

                //                 controller.modelsList.clear();
                //               },
                //             ),
                //     ),
                //   ),
                // ),
              ),
              SizedBox(height: 40),
              DottedBorder(
                child: Obx(
                  () => TextField(
                    controller: serielNumberController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintText: "Serial number...",
                      suffix: DropdownButton(
                        iconDisabledColor: Colors.black,
                        iconEnabledColor: Colors.black,
                        iconSize: 30,
                        items: controller.serielNumberList
                            .map(
                              (element) => DropdownMenuItem(
                                value: element,
                                child: SizedBox(
                                  width: 180,
                                  height: 20,
                                  child: Text(
                                    element["serial_number"],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) async {
                          serielNumberController.text = value!["serial_number"];

                          controller.modelReferenceOfSlNo.value = value["id"];

                          await controller.fetchWarrantyDetails();
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 60),
              Obx(
                () => Container(
                  width: Get.width,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: Get.width * 0.4,
                            child: Text(
                              "Warranty Status",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            ":   ${controller.warrantyStatus.value}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: Get.width * 0.4,
                            child: Text(
                              "PCB Warranty",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            ":   ${controller.pcbWarranty.value}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: Get.width * 0.4,
                            child: Text(
                              "Coil Warranty",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            ":   ${controller.coilWarranty.value}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: Get.width * 0.4,
                            child: Text(
                              "Compressor Warranty",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            ":   ${controller.compressorWarranty.value}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
