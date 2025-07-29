import 'package:flutter/material.dart';
import 'dart:io';

class JobConditionsAndPreferencesProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String? currentRank;
  String? alternateRank;
  List<String> preferredVesselTypes = [];
  String? preferredContractType;
  String? preferredPosition;
  String? manningAgency;
  String? currentAvailabilityStatus;
  DateTime? availableFrom;
  TextEditingController minOnBoardDurationController = TextEditingController();
  TextEditingController maxOnBoardDurationController = TextEditingController();
  TextEditingController minAtHomeDurationController = TextEditingController();
  TextEditingController maxAtHomeDurationController = TextEditingController();
  String? preferredRotationPattern;
  List<String> tradingAreaExclusions = [];
  TextEditingController lastJobSalaryController = TextEditingController();
  String? lastRankJoined;
  DateTime? lastPromotedDate;
  String? currency;
  File? justificationDocument;

  List<String> ranks = ["Captain", "Chief Officer", "Second Officer", "Third Officer", "Deck Cadet"];
  List<String> vesselTypes = ["Tanker", "Bulker", "Container", "Gas Carrier", "Offshore"];
  List<String> manningAgencies = ["Maersk", "MSC", "CMA CGM", "Cosco", "Hapag-Lloyd"];
  List<String> contractTypes = ["Voyage", "Permanent"];
  List<String> availabilityStatuses = ["Available", "Onboard", "On Leave"];
  List<String> rotationPatterns = ["3/3", "4/2", "6/6"];
  List<String> tradingAreas = ["Worldwide", "Europe", "Asia", "America"];
  List<String> currencies = ["USD", "EUR", "GBP"];

  void setCurrentRank(String value) {
    currentRank = value;
    notifyListeners();
  }

  void setAlternateRank(String value) {
    alternateRank = value;
    notifyListeners();
  }

  void setPreferredVesselTypes(List<String> values) {
    preferredVesselTypes = values;
    notifyListeners();
  }

  void setPreferredContractType(String value) {
    preferredContractType = value;
    notifyListeners();
  }

  void setPreferredPosition(String value) {
    preferredPosition = value;
    notifyListeners();
  }

  void setManningAgency(String value) {
    manningAgency = value;
    notifyListeners();
  }

  void setCurrentAvailabilityStatus(String value) {
    currentAvailabilityStatus = value;
    notifyListeners();
  }

  void setAvailableFrom(DateTime date) {
    availableFrom = date;
    notifyListeners();
  }

  void setPreferredRotationPattern(String value) {
    preferredRotationPattern = value;
    notifyListeners();
  }

  void setTradingAreaExclusions(List<String> values) {
    tradingAreaExclusions = values;
    notifyListeners();
  }

  void setLastRankJoined(String value) {
    lastRankJoined = value;
    notifyListeners();
  }

  void setLastPromotedDate(DateTime date) {
    lastPromotedDate = date;
    notifyListeners();
  }

  void setCurrency(String value) {
    currency = value;
    notifyListeners();
  }

  void setJustificationDocument(File file) {
    justificationDocument = file;
    notifyListeners();
  }

  void removeJustificationDocument() {
    justificationDocument = null;
    notifyListeners();
  }
}
