import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/rank_model.dart';
import '../../network/app_url.dart';
import '../../network/network_services.dart';

class ChooseRankProvider with ChangeNotifier {

  // Static variables for global access
  static String? _globalSelectedRankId;

  // Static getters for global access
  static String? get globalSelectedRankId => _globalSelectedRankId;

  // Static setters for global access
  static void setGlobalSelectedCountry(String? rankId, ) {
    _globalSelectedRankId = rankId;
  }

  // Static method to clear global country data
  static void clearGlobalSelectedCountry() {
    _globalSelectedRankId = null;
  }

  int? _selectedRankIndex;
  List<RankData> _ranks = [];

  // Getter for ranks list
  List<RankData> get ranks => _ranks;

  // Setter for ranks list
  set ranks(List<RankData>? newRanks) {
    _ranks = newRanks ?? [];
    notifyListeners();
  }

  // Getter for selectedRankIndex
  int? get selectedIndex => _selectedRankIndex;

  // Method to set or toggle selected rank
  void setSelectedRankIndex({required int index}) {
    if (_selectedRankIndex == index) {
      _selectedRankIndex = null; // Unselect if the same item is tapped
      setGlobalSelectedCountry(null); // Clear global rank ID
    } else {
      _selectedRankIndex = index; // Select the new item
      setGlobalSelectedCountry(_ranks[index].id); // Set global rank ID
    }
    notifyListeners();
  }

  bool get isRankSelected => _selectedRankIndex != null;

  Future<void> GetAllRank(BuildContext context) async {
    try {
      var response = await NetworkService().getResponse(
        getAllRank,
        false,
        context,
            () {},
      );
      print("RESPONSE ++>>> $response");
      if (response.isNotEmpty) {
        final profileData = GetAllRankModel.fromJson(response);
        if (profileData.statusCode == 200) {
          ranks = profileData.data; // Use setter to update ranks
        } else {
          ranks = []; // Clear ranks on error
          print("Error: Status code ${profileData.statusCode}, Message: ${profileData.message}");
        }
      } else {
        ranks = []; // Clear ranks if response is empty
        print("Error: Empty response from server");
      }
      notifyListeners();
    } catch (e) {
      ranks = []; // Clear ranks on exception
      print("Error in getAllRank: $e");
      notifyListeners();
    }
  }
}