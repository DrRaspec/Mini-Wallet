import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mini_wallet/bindings/app_binding.dart';
import 'package:mini_wallet/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const envFile = String.fromEnvironment(
    'ENV_FILE',
    defaultValue: 'assets/env/.env.dev',
  );

  await dotenv.load(fileName: envFile);

  await GetStorage.init();

  AppBinding().dependencies();

  runApp(const MainApp());
}
