import 'dart:math';

import 'package:flutter/material.dart';

class IMC {
  final String _id = UniqueKey().toString();
  double _weight = 0;
  double _height = 0;
  double _imcValue = 0;
  String _classification = "";

  IMC(this._height, this._weight);

  String get id => _id;
  double get weight => _weight;
  double get height => _height;
  double get imc => _imcValue;
  String get classification => _classification;

  set weight(double w) {
    if (w > 0 && w < 200) {
      _weight = w;
    }
  }

  set height(double h) {
    if (h > 0 && h < 2.30) {
      _height = h;
    }
  }

  void calculateIMC() {
    if (_height != 0 && _weight != 0) {
      _imcValue = _weight / pow(_height, 2);
      defineClassification();
    }
  }

  void defineClassification() {
    if (_imcValue < 16) {
      _classification = "Serious Thinness";
    } else if (_imcValue < 17) {
      _classification = "Moderated Thinness";
    } else if (_imcValue < 18.5) {
      _classification = "Small Thinness";
    } else if (_imcValue < 25) {
      _classification = "Healthy";
    } else if (_imcValue < 30) {
      _classification = "OverWeight";
    } else if (_imcValue < 35) {
      _classification = "Obesity 1";
    } else if (_imcValue < 40) {
      _classification = "Obesity 2";
    } else {
      _classification = "Obesity 3";
    }
  }
}
