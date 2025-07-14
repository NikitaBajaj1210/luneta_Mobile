import 'package:flutter/cupertino.dart';

class ProfessionalExamProvider with ChangeNotifier {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController scoreController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode scoreFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();
  DateTime? dateTaken;

  @override
  void dispose() {
    titleController.dispose();
    scoreController.dispose();
    descriptionController.dispose();
    titleFocusNode.dispose();
    scoreFocusNode.dispose();
    descriptionFocusNode.dispose();
    super.dispose();
  }
}