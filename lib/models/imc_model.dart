import 'dart:math';

import 'package:hive/hive.dart';
part 'imc_model.g.dart';

@HiveType(typeId: 0)
class IMCModel extends HiveObject {
  @HiveField(0)
  String name = "";

  @HiveField(1)
  double height = 0;

  @HiveField(2)
  double weight = 0;

  @HiveField(3)
  double imc = 0;

  @HiveField(4)
  String classification = "";

  IMCModel();

  IMCModel.create(this.name, this.height, this.weight);
  void calculateIMC() {
    if (height != 0 && weight != 0) {
      imc = weight / pow(height, 2);
      defineClassification();
      // save();
    }
  }

  void defineClassification() {
    if (imc < 16) {
      classification = "Serious Thinness";
    } else if (imc < 17) {
      classification = "Moderated Thinness";
    } else if (imc < 18.5) {
      classification = "Small Thinness";
    } else if (imc < 25) {
      classification = "Healthy";
    } else if (imc < 30) {
      classification = "OverWeight";
    } else if (imc < 35) {
      classification = "Obesity 1";
    } else if (imc < 40) {
      classification = "Obesity 2";
    } else {
      classification = "Obesity 3";
    }
  }
}
