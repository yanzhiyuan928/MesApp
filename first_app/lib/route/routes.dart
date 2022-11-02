// ignore_for_file: unused_import

import 'package:first_app/assemblyPartTrack.dart';
import 'package:first_app/main.dart';
import 'package:first_app/productionLog.dart';
import 'package:first_app/rawMaterial.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../barCodeInfo.dart';
import '../defectInfo.dart';

final routes = <String, WidgetBuilder>{
  '/login': (context) => const HomePage(),
  '/barCodeInfo': (context) => const BarCodePage(),
  '/productionLog': (context) => const ProductionPage(),
  '/assemblyPartTrack': (context) => const assemblyPartPage(),
  '/rawMaterial': (context) => const rawMaterialPage(),
  '/defectInfo': (context) => const defectInfoPage(),
};
