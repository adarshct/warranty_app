import 'dart:convert';
import 'dart:ffi';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Controller extends GetxController {
  RxList<Map<String, dynamic>> modelsList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> serielNumberList = <Map<String, dynamic>>[].obs;
  // RxString modelName = "".obs;
  RxString modelReference = "".obs;
  RxString modelReferenceOfSlNo = "".obs;
  RxString warrantyStatus = "".obs;
  RxString pcbWarranty = "".obs;
  RxString coilWarranty = "".obs;
  RxString compressorWarranty = "".obs;

  Future<void> fetchProductModels({required String query}) async {
    var url = Uri.parse(
        "http://192.168.29.160:8001/api/v1/general/all-product-modals/?query=$query");

    Map<String, String> headers = {"Content-type": "application/json"};

    var response = await http.get(url, headers: headers);

    List data = json.decode(response.body);

    modelsList.clear();

    data.forEach((element) {
      modelsList.add(element);
    });
  }

  Future<void> fetchSerielNumbers() async {
    var url = Uri.parse(
        "http://192.168.29.160:8001/api/v1/general/serial-numbers-by-modal-reference/?product_model_reference=${modelReference.value}&saled=1");

    Map<String, String> headers = {"Content-type": "application/json"};

    var response = await http.get(url, headers: headers);

    print(modelReference.value);

    List data = json.decode(response.body);

    serielNumberList.clear();

    data.forEach((element) {
      serielNumberList.add(element);
    });
  }

  Future<void> fetchWarrantyDetails() async {
    var url = Uri.parse(
        "http://192.168.29.160:8001/api/v1/general/get-warranty-details/?product_model_reference=${modelReferenceOfSlNo.value}");

    print(modelReferenceOfSlNo.value);

    Map<String, String> headers = {"Content-type": "application/json"};

    var response = await http.get(url, headers: headers);

    print(response.body);

    Map<String, dynamic> data = json.decode(response.body);

    warrantyStatus.value = data["warranty_status"];
    pcbWarranty.value = data["pcb_warranty"];
    coilWarranty.value = data["coil_warranty"];
    compressorWarranty.value = data["compressor_warranty"];
  }
}
