import 'package:flutter/material.dart';
import 'package:mini_wallet/bindings/initial_binding.dart';
import 'package:mini_wallet/my_app.dart';

void main() {
  InitialBinding().dependencies();
  runApp(const MainApp());
}
