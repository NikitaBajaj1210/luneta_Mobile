import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class ProfessionalSkillsProvider with ChangeNotifier {
  // Computer and Software
  List<ComputerAndSoftware> computerAndSoftwareList = [];
  bool showAddSection_computerAndSoftware = false;
  int? computerAndSoftware_Edit_Index;
  bool computerAndSoftware_IsEdit = false;

  String? software;
  String? level;

  List<String> softwareList = ["Danaos", "Benefit", "BASS net"];
  List<String> levelList = ["Fair", "Good", "Very Good", "Excellent"];

  void setSoftware(String value) {
    software = value;
    notifyListeners();
  }

  void setLevel(String value) {
    level = value;
    notifyListeners();
  }

  void addComputerAndSoftware(ComputerAndSoftware item) {
    computerAndSoftwareList.add(item);
    notifyListeners();
  }

  void editComputerAndSoftware(int index) {
    computerAndSoftware_Edit_Index = index;
    computerAndSoftware_IsEdit = true;
    software = computerAndSoftwareList[index].software;
    level = computerAndSoftwareList[index].level;
    setComputerAndSoftwareVisibility(true);
  }

  void updateComputerAndSoftware(int index, ComputerAndSoftware item) {
    computerAndSoftwareList[index] = item;
    notifyListeners();
  }

  void removeComputerAndSoftware(int index) {
    computerAndSoftwareList.removeAt(index);
    notifyListeners();
  }

  void setComputerAndSoftwareVisibility(bool value) {
    showAddSection_computerAndSoftware = value;
    if (!value) {
      software = null;
      level = null;
      computerAndSoftware_IsEdit = false;
      computerAndSoftware_Edit_Index = null;
    }
    notifyListeners();
  }
}

class ComputerAndSoftware {
  final String software;
  final String level;

  ComputerAndSoftware({required this.software, required this.level});
}
