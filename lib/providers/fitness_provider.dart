import 'package:flutter/material.dart';

class FitnessProvider extends ChangeNotifier {
  Map<String, int> _stepsData = {};
  Map<String, double> _waterData = {};

  Map<String, int> get stepsData => _stepsData;
  Map<String, double> get waterData => _waterData;

  void addSteps(String date, int steps) {
    _stepsData[date] = steps;
    notifyListeners();
  }

  void removeSteps(String date) {
    _stepsData.remove(date);
    notifyListeners();
  }

  void addWater(String date, double liters) {
    _waterData[date] = liters;
    notifyListeners();
  }

  void removeWater(String date) {
    _waterData.remove(date);
    notifyListeners();
  }
}
