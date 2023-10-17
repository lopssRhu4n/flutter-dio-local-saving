import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:imc_app/app.dart';
import 'package:imc_app/models/imc_model.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var docsDir = await getApplicationDocumentsDirectory();
  Hive.init(docsDir.path);
  Hive.registerAdapter(IMCModelAdapter());
  runApp(const App());
}
