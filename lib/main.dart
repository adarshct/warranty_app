import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_app/home_page.dart';

void main() {
  runApp(WarrantyApp());
}

class WarrantyApp extends StatelessWidget {
  const WarrantyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomePage(),
    );
  }
}
