import 'package:flutter/material.dart';

class SkillsProvider extends ChangeNotifier {
  final TextEditingController _skillController = TextEditingController();
  final FocusNode _skillFocusNode = FocusNode();

  List<String> _skills = [];

  TextEditingController get skillController => _skillController;
  FocusNode get skillFocusNode => _skillFocusNode;
  List<String> get skills => _skills;

  void addSkill(String skill) {
    if (!_skills.contains(skill)) {
      _skills.add(skill);
      notifyListeners();
    }
  }

  void removeSkill(String skill) {
    _skills.remove(skill);
    notifyListeners();
  }

  void resetForm() {
    _skillController.clear();
    _skills.clear();
    notifyListeners();
  }

  void initializeWithData({required List<String> skills}) {
    // resetForm();
    _skills = List<String>.from(skills);
    notifyListeners();
  }

  @override
  void dispose() {
    _skillController.dispose();
    _skillFocusNode.dispose();
    super.dispose();
  }
}
