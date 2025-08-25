import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:luneta/models/professional_skills_model.dart';
import '../../../../const/color.dart';
import '../../../../const/font_size.dart';
import '../../../../custom-component/customTextField.dart';
import '../../../../network/app_url.dart';
import '../../../../network/network_helper.dart';
import '../../../../network/network_services.dart';
import '../../../../Utils/helper.dart';
import '../../../../custom-component/globalComponent.dart';

class ProfessionalSkillsProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  // Data state
  Map<String, dynamic>? professionalSkillsData;

  // Vetting Inspection Document
  // File? _vettingInspectionDocument;
  // String? _vettingInspectionDocumentPath;

  // File? get vettingInspectionDocument => _vettingInspectionDocument;
  // String? get vettingInspectionDocumentPath => _vettingInspectionDocumentPath;


  Future<void> setVettingInspectionDocument(File? file, BuildContext? context) async {
    // Add file size validation (20MB limit)
    if (file != null) {
      final maxSize = 20 * 1024 * 1024; // 20MB in bytes
      final size = await file.length();
      if (size > maxSize) {
        // Show error message
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('File size exceeds 20MB limit'),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          print('File size exceeds 20MB limit');
        }
        return;
      }
    }
    // _vettingInspectionDocument = file;
    notifyListeners();
  }

  // Future<void> removeVettingInspectionDocument(BuildContext? context) async {
  //   _vettingInspectionDocument = null;
  //   _vettingInspectionDocumentPath = null;
  //   notifyListeners();
  // }


  // Computer and Software
  List<ComputerAndSoftware> computerAndSoftwareList = [];
  bool _showAddSection_computerAndSoftware = false;
   bool get showAddSection_computerAndSoftware => _showAddSection_computerAndSoftware;

  set showAddSection_computerAndSoftware(bool value) {
    _showAddSection_computerAndSoftware = value;
  }
  int? computerAndSoftware_Edit_Index;
  bool computerAndSoftware_IsEdit = false;
  String? software;
  String? level;
  List<String> softwareList = ["Danaos", "Benefit", "BASS net","Other"];
  List<String> levelList = ["Fair", "Good", "Very Good", "Excellent","Beginner","Intermediate","Advanced"];

  // Get available software options excluding already selected ones
  List<String> getAvailableSoftwareList() {
    List<String> selectedSoftware = computerAndSoftwareList.map((e) => e.software).toList();
    
    // If editing, include the current item's software in available options
    if (computerAndSoftware_IsEdit && computerAndSoftware_Edit_Index != null) {
      String currentSoftware = computerAndSoftwareList[computerAndSoftware_Edit_Index!].software;
      selectedSoftware.remove(currentSoftware);
    }
    
    return softwareList.where((software) => !selectedSoftware.contains(software)).toList();
  }

  void setSoftware(String value) {
    software = value;
    notifyListeners();
  }

  void setLevel(String value) {
    level = value;
    notifyListeners();
  }

  void addComputerAndSoftware() {
    if (software != null && level != null) {
      if (computerAndSoftware_IsEdit) {
        computerAndSoftwareList[computerAndSoftware_Edit_Index!] =
            ComputerAndSoftware(software: software!, level: level!);
      } else {
        computerAndSoftwareList
            .add(ComputerAndSoftware(software: software!, level: level!));
      }
      setComputerAndSoftwareVisibility(false);
      software = null;
      level = null;
      computerAndSoftware_IsEdit = false;
      computerAndSoftware_Edit_Index = null;
    }
  }

  void removeComputerAndSoftware(int index) {
    computerAndSoftwareList.removeAt(index);
    notifyListeners();
  }

  void setComputerAndSoftwareVisibility(bool value) {
    showAddSection_computerAndSoftware = value;
    notifyListeners();
  }

  // Cargo Experience
  bool cargoExperience = false;
  List<String> bulkCargo = [];
  List<String> tankerCargo = [];
  List<String> generalCargo = [];
  List<String> woodProducts = [];
  List<String> stowageAndLashingExperience = [];

  List<CargoData> bulkCargoList_data = [];
  List<CargoData> tankerCargoList_data = [];
  List<CargoData> generalCargoList_data = [];
  List<CargoData> woodProductsList_data = [];
  List<CargoData> stowageAndLashingExperienceList_data = [];

  void setCargoExperience(bool value) {
    cargoExperience = value;
    notifyListeners();
  }

  Future<void> getBulkCargo(context) async {
    try {
      final response = await NetworkService().getResponse(
        getMasterCargoExperience,
        false,
        context,
        () {},
      );
      if (response != null && response['data'] != null) {
        CargoResponse parsedResponse = CargoResponse.fromJson(response);
        bulkCargoList_data = parsedResponse.data ?? [];
      }
      notifyListeners();
    } catch (e) {
      print("Exception in getBulkCargo $e");
    }
  }

  Future<void> getTankerCargo(context) async {
    try {
      final response = await NetworkService().getResponse(
        getMasterTankerCargo,
        false,
        context,
        () {},
      );
      if (response != null && response['data'] != null) {
        CargoResponse parsedResponse = CargoResponse.fromJson(response);
        tankerCargoList_data = parsedResponse.data ?? [];
      }
      notifyListeners();
    } catch (e) {
      print("Exception in getTankerCargo $e");
    }
  }

  Future<void> getGeneralCargo(context) async {
    try {
      final response = await NetworkService().getResponse(
        getMasterGeneralCargo,
        false,
        context,
        () {},
      );
      if (response != null && response['data'] != null) {
        CargoResponse parsedResponse = CargoResponse.fromJson(response);
        generalCargoList_data = parsedResponse.data ?? [];
      }
      notifyListeners();
    } catch (e) {
      print("Exception in getGeneralCargo $e");
    }
  }

  Future<void> getWoodProducts(context) async {
    try {
      final response = await NetworkService().getResponse(
        getMasterWoodProduct,
        false,
        context,
        () {},
      );
      if (response != null && response['data'] != null) {
        CargoResponse parsedResponse = CargoResponse.fromJson(response);
        woodProductsList_data = parsedResponse.data ?? [];
      }
      notifyListeners();
    } catch (e) {
      print("Exception in getWoodProducts $e");
    }
  }

  Future<void> getLashingExperience(context) async {
    try {
      final response = await NetworkService().getResponse(
        getMasterLashingExperience,
        false,
        context,
        () {},
      );
      if (response != null && response['data'] != null) {
        CargoResponse parsedResponse = CargoResponse.fromJson(response);
        stowageAndLashingExperienceList_data = parsedResponse.data ?? [];
      }
      notifyListeners();
    } catch (e) {
      print("Exception in getLashingExperience $e");
    }
  }

  Future<void> fetchDropdownData(BuildContext context) async {
    await getBulkCargo(context);
    await getTankerCargo(context);
    await getGeneralCargo(context);
    await getWoodProducts(context);
    await getLashingExperience(context);
    await fetchProfessionalSkillsData(context);

  }

  Future<bool> createOrUpdateCargo(
      String endpoint, String name, BuildContext context) async {
    try {
      final response = await NetworkService().postResponse(
        endpoint,
        jsonEncode({'name': name}),
        true,
        context,
        () {},
      );
      if (response != null && response['statusCode'] == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print("Exception in createOrUpdateCargo $e");
      return false;
    }
  }

  String? _validateCargoName(String value) {
    // First check: empty string
    if (value.isEmpty) {
      return 'please enter Cargo Name';
    }
    
    // Second check: only whitespace
    if (value.trim().isEmpty) {
      return 'please enter valid Cargo Name';
    }
    
    // Third check: contains only whitespace characters
    if (value.replaceAll(RegExp(r'\s+'), '').isEmpty) {
      return 'please enter valid Cargo Name';
    }
    
    // Fourth check: emojis
    final emojiRegex = RegExp(r'[\u{1F600}-\u{1F64F}]|[\u{1F300}-\u{1F5FF}]|[\u{1F680}-\u{1F6FF}]|[\u{1F1E0}-\u{1F1FF}]|[\u{2600}-\u{26FF}]|[\u{2700}-\u{27BF}]', unicode: true);
    if (emojiRegex.hasMatch(value)) {
      return 'emojis are not allowed';
    }
    
    return null;
  }

  void showAddCargoDialog(BuildContext context, String title, String endpoint,
      Function onSave) {
    final nameController = TextEditingController();
    final FocusNode _focusNode = FocusNode(); // Add focus node to maintain focus
    String? errorMessage; // Move outside builder to persist state
    
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(title),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customTextField(
                    context: context,
                    controller: nameController,
                    focusNode: _focusNode, // Add focus node
                    hintText: 'Enter Name',
                    textInputType: TextInputType.text,
                    obscureText: false,
                    voidCallback: (value) {},
                    fontSize: AppFontSize.fontSize16,
                    inputFontSize: AppFontSize.fontSize16,
                    backgroundColor: AppColors.Color_FAFAFA,
                    borderColor: AppColors.buttonColor,
                    textColor: Colors.black,
                    labelColor: AppColors.Color_9E9E9E,
                    cursorColor: AppColors.Color_212121,
                    fillColor: AppColors.Color_FAFAFA,
                    onFieldSubmitted: (String) {},
                    onChange: (value) {
                      setDialogState(() {
                        errorMessage = _validateCargoName(value);
                      });
                    },
                  ),
                  if (errorMessage != null)
                    Padding(
                      padding: EdgeInsets.only(top: 8.0, left: 4.0),
                      child: Text(
                        errorMessage!,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: AppFontSize.fontSize12,
                        ),
                      ),
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child:  Text("Cancel",style:TextStyle(
                    fontSize: AppFontSize.fontSize18,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppColors.fontFamilyMedium,
                    color: AppColors.buttonColor,
                  ),),
                ),
                TextButton(
                  onPressed: () async {
                    final validation = _validateCargoName(nameController.text);
                    if (validation == null) {
                      bool success = await createOrUpdateCargo(
                          endpoint, nameController.text.toString().trim(), context);
                      if (success) {
                        onSave();
                        Navigator.pop(context);
                      }
                    } else {
                      setDialogState(() {
                        errorMessage = validation;
                      });
                    }
                  },
                  child: Text("Add",style:TextStyle(
                    fontSize: AppFontSize.fontSize18,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppColors.fontFamilyMedium,
                    color: AppColors.buttonColor,
                  ),),
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      _focusNode.dispose(); // Dispose focus node when dialog closes
    });
  }

  // Cargo Gear Experience
  bool cargoGearExperience = false;
  List<CargoGearExperience> cargoGearExperienceList = [];
  bool _showAddSection_cargoGearExperience = false;

  bool get showAddSection_cargoGearExperience => _showAddSection_cargoGearExperience;

  set showAddSection_cargoGearExperience(bool value) {
    _showAddSection_cargoGearExperience = value;
  }
  int? cargoGearExperience_Edit_Index;
  bool cargoGearExperience_IsEdit = false;
  String? cargoGearType;
  final cargoGearMakerController = TextEditingController();
  final cargoGearSWLController = TextEditingController();
  
  // FocusNodes for Cargo Gear Experience
  final cargoGearMakerFocusNode = FocusNode();
  final cargoGearSWLFocusNode = FocusNode();
  
  List<String> cargoGearTypes = ["Cranes", "Grabs"];

  // Get available cargo gear types excluding already selected ones
  List<String> getAvailableCargoGearTypes() {
    List<String> selectedTypes = cargoGearExperienceList.map((e) => e.type).toList();
    
    // If editing, include the current item's type in available options
    if (cargoGearExperience_IsEdit && cargoGearExperience_Edit_Index != null) {
      String currentType = cargoGearExperienceList[cargoGearExperience_Edit_Index!].type;
      selectedTypes.remove(currentType);
    }
    
    return cargoGearTypes.where((type) => !selectedTypes.contains(type)).toList();
  }

  void setCargoGearExperience(bool value) {
    cargoGearExperience = value;
    notifyListeners();
  }

  void setCargoGearType(String value) {
    cargoGearType = value;
    notifyListeners();
  }

  void addCargoGearExperience() {
    if (cargoGearType != null &&
        cargoGearMakerController.text.isNotEmpty &&
        cargoGearSWLController.text.isNotEmpty) {
      if (cargoGearExperience_IsEdit) {
        cargoGearExperienceList[cargoGearExperience_Edit_Index!] =
            CargoGearExperience(
                type: cargoGearType!,
                maker: cargoGearMakerController.text,
                swl: cargoGearSWLController.text);
      } else {
        cargoGearExperienceList.add(CargoGearExperience(
            type: cargoGearType!,
            maker: cargoGearMakerController.text,
            swl: cargoGearSWLController.text));
      }
      setCargoGearExperienceVisibility(false);
      cargoGearType = null;
      cargoGearMakerController.clear();
      cargoGearSWLController.clear();
      cargoGearExperience_IsEdit = false;
      cargoGearExperience_Edit_Index = null;
    }
  }

  void editCargoGearExperience(int index) {
    cargoGearExperience_Edit_Index = index;
    cargoGearExperience_IsEdit = true;
    cargoGearType = cargoGearExperienceList[index].type;
    cargoGearMakerController.text = cargoGearExperienceList[index].maker;
    cargoGearSWLController.text = cargoGearExperienceList[index].swl;
    setCargoGearExperienceVisibility(true);
  }

  void removeCargoGearExperience(int index) {
    cargoGearExperienceList.removeAt(index);
    notifyListeners();
  }

  void setCargoGearExperienceVisibility(bool value) {
    showAddSection_cargoGearExperience = value;
    notifyListeners();
  }

  // Metal Working Skills
  bool metalWorkingSkills = false;
  List<MetalWorkingSkill> metalWorkingSkillsList = [];
  bool _showAddSection_metalWorkingSkills = false;

  bool get showAddSection_metalWorkingSkills => _showAddSection_metalWorkingSkills;

  set showAddSection_metalWorkingSkills(bool value) {
    _showAddSection_metalWorkingSkills = value;
  }
  int? metalWorkingSkills_Edit_Index;
  bool metalWorkingSkills_IsEdit = false;
  String? metalWorkingSkill;
  String? metalWorkingSkillLevel;
  bool metalWorkingSkillCertificate = false;
  File? metalWorkingSkillDocument;
  List<String> metalWorkingSkillsTypes = [
    "Arc welding",
    "Gas welding",
    "Inert gas welding",
    "Lathe"
  ];
  // List<String> metalWorkingSkillLevelList = ["Beginner", "Intermediate"];

  // Get available metal working skills types excluding already selected ones
  List<String> getAvailableMetalWorkingSkillsTypes() {
    List<String> selectedSkills = metalWorkingSkillsList.map((e) => e.skillSelection).toList();
    
    // If editing, include the current item's skill in available options
    if (metalWorkingSkills_IsEdit && metalWorkingSkills_Edit_Index != null) {
      String currentSkill = metalWorkingSkillsList[metalWorkingSkills_Edit_Index!].skillSelection;
      selectedSkills.remove(currentSkill);
    }
    
    return metalWorkingSkillsTypes.where((skill) => !selectedSkills.contains(skill)).toList();
  }

  void setMetalWorkingSkills(bool value) {
    metalWorkingSkills = value;
    notifyListeners();
  }

  void setMetalWorkingSkill(String value) {
    metalWorkingSkill = value;
    notifyListeners();
  }

  void setMetalWorkingSkillLevel(String value) {
    metalWorkingSkillLevel = value;
    notifyListeners();
  }

  void setMetalWorkingSkillCertificate(bool value) {
    metalWorkingSkillCertificate = value;
    notifyListeners();
  }

  void setMetalWorkingSkillDocument(File? file) {
    metalWorkingSkillDocument = file;
    notifyListeners();
  }

  void removeMetalWorkingSkillDocument() {

    if (metalWorkingSkillDocument != null) {
      print("Returning new document path: ${metalWorkingSkillDocument!.path}");
      metalWorkingSkillDocument = null;
    } else if (metalWorkingSkills_IsEdit &&
        metalWorkingSkills_Edit_Index != null &&
        metalWorkingSkillsList[metalWorkingSkills_Edit_Index!].documentPath != null &&
        metalWorkingSkillsList[metalWorkingSkills_Edit_Index!].documentPath!.isNotEmpty) {
      metalWorkingSkillsList[metalWorkingSkills_Edit_Index!].documentPath=null;
      metalWorkingSkillsList[metalWorkingSkills_Edit_Index!].originalName=null;
    }

    notifyListeners();
  }

  void addMetalWorkingSkill() {
    if (metalWorkingSkill != null && metalWorkingSkillLevel != null) {
      if (metalWorkingSkills_IsEdit) {
        // When editing, preserve existing documentPath if no new document is selected
        String? existingDocumentPath = metalWorkingSkillsList[metalWorkingSkills_Edit_Index!].documentPath;
        String? newDocumentPath = metalWorkingSkillDocument?.path ?? existingDocumentPath;
        
        metalWorkingSkillsList[metalWorkingSkills_Edit_Index!] =
            MetalWorkingSkill(
                skillSelection: metalWorkingSkill!,
                level: metalWorkingSkillLevel!,
                certificate: metalWorkingSkillCertificate,
                document: metalWorkingSkillDocument,
                documentPath: newDocumentPath,
              originalName: metalWorkingSkillDocument==null?metalWorkingSkillsList[metalWorkingSkills_Edit_Index!].originalName:newDocumentPath!.split('/').last
            );
      } else {
        metalWorkingSkillsList.add(MetalWorkingSkill(
            skillSelection: metalWorkingSkill!,
            level: metalWorkingSkillLevel!,
            certificate: metalWorkingSkillCertificate,
            document: metalWorkingSkillDocument,
            documentPath: metalWorkingSkillDocument?.path ?? '',
            originalName: metalWorkingSkillDocument==null?metalWorkingSkillsList[metalWorkingSkills_Edit_Index!].originalName:metalWorkingSkillDocument?.path.split('/').last
        ));
      }
      setMetalWorkingSkillsVisibility(false);
      metalWorkingSkill = null;
      metalWorkingSkillLevel = null;
      metalWorkingSkillCertificate = false;
      metalWorkingSkillDocument = null;
      metalWorkingSkills_IsEdit = false;
      metalWorkingSkills_Edit_Index = null;
    }
  }

  void editMetalWorkingSkill(int index) {
    metalWorkingSkills_Edit_Index = index;
    metalWorkingSkills_IsEdit = true;
    metalWorkingSkill = metalWorkingSkillsList[index].skillSelection;
    metalWorkingSkillLevel = metalWorkingSkillsList[index].level;
    metalWorkingSkillCertificate = metalWorkingSkillsList[index].certificate;
    metalWorkingSkillDocument = metalWorkingSkillsList[index].document;
    // Note: documentPath is already available in the object for UI display
    setMetalWorkingSkillsVisibility(true);
  }

  // Get the current document path for display (either new document or existing one)
  String? getCurrentMetalWorkingSkillDocumentPath() {
    print("getCurrentMetalWorkingSkillDocumentPath called");
    print("metalWorkingSkillDocument: ${metalWorkingSkillDocument?.path}");
    print("metalWorkingSkills_IsEdit: $metalWorkingSkills_IsEdit");
    print("metalWorkingSkills_Edit_Index: $metalWorkingSkills_Edit_Index");
    
    if (metalWorkingSkillDocument != null) {
      print("Returning new document path: ${metalWorkingSkillDocument!.path}");
      return metalWorkingSkillDocument!.path;
    } else if (metalWorkingSkills_IsEdit && 
               metalWorkingSkills_Edit_Index != null &&
               metalWorkingSkillsList[metalWorkingSkills_Edit_Index!].documentPath != null &&
               metalWorkingSkillsList[metalWorkingSkills_Edit_Index!].documentPath!.isNotEmpty) {
      String existingPath = metalWorkingSkillsList[metalWorkingSkills_Edit_Index!].documentPath!;
      print("Returning existing document path: $existingPath");
      return existingPath;
    }
    print("No document path found");
    return null;
  }

  void removeMetalWorkingSkill(int index) {
    metalWorkingSkillsList.removeAt(index);
    // Reset edit index if we're removing the currently edited item
    if (metalWorkingSkills_Edit_Index == index) {
      metalWorkingSkills_Edit_Index = null;
      metalWorkingSkills_IsEdit = false;
    }
    // Adjust edit index if we're removing an item before the currently edited item
    else if (metalWorkingSkills_Edit_Index != null && metalWorkingSkills_Edit_Index! > index) {
      metalWorkingSkills_Edit_Index = metalWorkingSkills_Edit_Index! - 1;
    }
    notifyListeners();
  }

  void setMetalWorkingSkillsVisibility(bool value) {
    showAddSection_metalWorkingSkills = value;
    notifyListeners();
  }

  // Tank Coating Experience
  bool tankCoatingExperience = false;
  List<TankCoatingExperience> tankCoatingExperienceList = [];
  bool _showAddSection_tankCoatingExperience = false;

  bool get showAddSection_tankCoatingExperience => _showAddSection_tankCoatingExperience;

  set showAddSection_tankCoatingExperience(bool value) {
    _showAddSection_tankCoatingExperience = value;
  }
  int? tankCoatingExperience_Edit_Index;
  bool tankCoatingExperience_IsEdit = false;
  String? tankCoatingType;
  List<String> tankCoatingTypes = ["Epoxy", "Steel", "Stainless Steel"];

  // Get available tank coating types excluding already selected ones
  List<String> getAvailableTankCoatingTypes() {
    List<String> selectedTypes = tankCoatingExperienceList.map((e) => e.type).toList();
    
    // If editing, include the current item's type in available options
    if (tankCoatingExperience_IsEdit && tankCoatingExperience_Edit_Index != null) {
      String currentType = tankCoatingExperienceList[tankCoatingExperience_Edit_Index!].type;
      selectedTypes.remove(currentType);
    }
    
    return tankCoatingTypes.where((type) => !selectedTypes.contains(type)).toList();
  }

  void setTankCoatingExperience(bool value) {
    tankCoatingExperience = value;
    notifyListeners();
  }

  void setTankCoatingType(String value) {
    tankCoatingType = value;
    notifyListeners();
  }

  void addTankCoatingExperience() {
    if (tankCoatingType != null) {
      if (tankCoatingExperience_IsEdit) {
        tankCoatingExperienceList[tankCoatingExperience_Edit_Index!] =
            TankCoatingExperience(type: tankCoatingType!);
      } else {
        tankCoatingExperienceList
            .add(TankCoatingExperience(type: tankCoatingType!));
      }
      setTankCoatingExperienceVisibility(false);
      tankCoatingType = null;
      tankCoatingExperience_IsEdit = false;
      tankCoatingExperience_Edit_Index = null;
    }
  }

  void editTankCoatingExperience(int index) {
    tankCoatingExperience_Edit_Index = index;
    tankCoatingExperience_IsEdit = true;
    tankCoatingType = tankCoatingExperienceList[index].type;
    setTankCoatingExperienceVisibility(true);
  }

  void removeTankCoatingExperience(int index) {
    tankCoatingExperienceList.removeAt(index);
    notifyListeners();
  }

  void setTankCoatingExperienceVisibility(bool value) {
    showAddSection_tankCoatingExperience = value;
    notifyListeners();
  }

  // Port State Control Experience
  bool portStateControlExperience = false;
  List<PortStateControlExperience> portStateControlExperienceList = [];
  bool _showAddSection_portStateControlExperience = false;

  bool get showAddSection_portStateControlExperience => _showAddSection_portStateControlExperience;

  set showAddSection_portStateControlExperience(bool value) {
    _showAddSection_portStateControlExperience = value;
  }
  int? portStateControlExperience_Edit_Index;
  bool portStateControlExperience_IsEdit = false;
  String? regionalAgreement;
  String? port;
  final dateController = TextEditingController();
  final observationsController = TextEditingController();
  
  // FocusNodes for Port State Control Experience
  final dateFocusNode = FocusNode();
  final observationsFocusNode = FocusNode();
  
  List<String> regionalAgreements = ["AMSA", "China Federation",'USCG'];
  List<String> ports = ["DOCKED", "AT_SEA", "ANCHORAGE","IN_TRANSIT","IN_PORT","LOADING","UNLOADING","MAINTENANCE"];

  // Get available regional agreements excluding already selected ones
  List<String> getAvailableRegionalAgreements() {
    List<String> selectedAgreements = portStateControlExperienceList.map((e) => e.regionalAgreement).toList();
    
    // If editing, include the current item's agreement in available options
    if (portStateControlExperience_IsEdit && portStateControlExperience_Edit_Index != null) {
      String currentAgreement = portStateControlExperienceList[portStateControlExperience_Edit_Index!].regionalAgreement;
      selectedAgreements.remove(currentAgreement);
    }
    
    return regionalAgreements.where((agreement) => !selectedAgreements.contains(agreement)).toList();
  }

  // Get available ports excluding already selected ones
  List<String> getAvailablePorts() {
    List<String> selectedPorts = portStateControlExperienceList.map((e) => e.port).toList();
    
    // If editing, include the current item's port in available options
    if (portStateControlExperience_IsEdit && portStateControlExperience_Edit_Index != null) {
      String currentPort = portStateControlExperienceList[portStateControlExperience_Edit_Index!].port;
      selectedPorts.remove(currentPort);
    }
    
    return ports.where((port) => !selectedPorts.contains(port)).toList();
  }

  void setPortStateControlExperience(bool value) {
    portStateControlExperience = value;
    notifyListeners();
  }

  void setRegionalAgreement(String value) {
    regionalAgreement = value;
    notifyListeners();
  }

  void setPort(String value) {
    port = value;
    notifyListeners();
  }

  void setDate(DateTime date) {
    dateController.text = DateFormat('yyyy-MM-dd').format(date);
    notifyListeners();
  }

  void addPortStateControlExperience() {
    if (regionalAgreement != null &&
        port != null &&
        dateController.text.isNotEmpty) {
      if (portStateControlExperience_IsEdit) {
        portStateControlExperienceList[portStateControlExperience_Edit_Index!] =
            PortStateControlExperience(
                regionalAgreement: regionalAgreement!,
                port: port!,
                date: dateController.text,
                observations: observationsController.text);
      } else {
        portStateControlExperienceList.add(PortStateControlExperience(
            regionalAgreement: regionalAgreement!,
            port: port!,
            date: dateController.text,
            observations: observationsController.text));
      }
      setPortStateControlExperienceVisibility(false);
      regionalAgreement = null;
      port = null;
      dateController.clear();
      observationsController.clear();
      portStateControlExperience_IsEdit = false;
      portStateControlExperience_Edit_Index = null;
    }
  }

  void editPortStateControlExperience(int index) {
    portStateControlExperience_Edit_Index = index;
    portStateControlExperience_IsEdit = true;
    regionalAgreement = portStateControlExperienceList[index].regionalAgreement;
    port = portStateControlExperienceList[index].port;
    dateController.text = portStateControlExperienceList[index].date;
    observationsController.text =
        portStateControlExperienceList[index].observations;
    setPortStateControlExperienceVisibility(true);
  }

  void removePortStateControlExperience(int index) {
    portStateControlExperienceList.removeAt(index);
    notifyListeners();
  }

  void setPortStateControlExperienceVisibility(bool value) {
    showAddSection_portStateControlExperience = value;
    notifyListeners();
  }

  // Vetting Inspection Experience
  final inspectionByController = TextEditingController();
  String? vettingPort;
  final vettingDateController = TextEditingController();
  final vettingObservationsController = TextEditingController();
  
  // FocusNodes for Vetting Inspection Experience
  final inspectionByFocusNode = FocusNode();
  final vettingDateFocusNode = FocusNode();
  final vettingObservationsFocusNode = FocusNode();
  
  List<String> vettingPorts = ["New York", "Los Angeles", "Shanghai"];

  // Get available vetting ports (no filtering needed as this is a single item, not a list)
  List<String> getAvailableVettingPorts() {
    return vettingPorts;
  }

  void setVettingPort(String value) {
    vettingPort = value;
    notifyListeners();
  }

  void setVettingDate(DateTime date) {
    vettingDateController.text = DateFormat('yyyy-MM-dd').format(date);
    notifyListeners();
  }

  // Trading Area Experience
  List<String> tradingAreaExperience = [];
  List<String> tradingAreaList = ["Asia", "Europe", "Middle East","Africa","North America","South America","Australia"];

  // File Picker
  final ImagePicker _picker = ImagePicker();

  Future<void> showAttachmentOptions(BuildContext context, String type) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery, type, context);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Take a picture'),
                onTap: () {
                  _pickImage(ImageSource.camera, type, context);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.description),
                title: Text('Choose a document'),
                onTap: () {
                  _pickDocument(type, context);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickDocument(String type, BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );
    if (result != null) {
      final file = File(result.files.single.path!);
      if (type == 'metalWorkingSkill') {
        setMetalWorkingSkillDocument(file);
      } else if (type == 'vettingDocument') {
        await setVettingInspectionDocument(file, context);
      }
    }
  }

  Future<void> _pickImage(ImageSource source, String type, BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      if (type == 'metalWorkingSkill') {
        setMetalWorkingSkillDocument(file);
      } else if (type == 'vettingDocument') {
        await setVettingInspectionDocument(file, context);
      }
    }
  }

  void removeAttachment(String type) {
    if (type == 'metalWorkingSkill') {
      setMetalWorkingSkillDocument(null);
      // Also clear documentPath if editing an existing item
      if (metalWorkingSkills_Edit_Index != null &&
          metalWorkingSkills_Edit_Index! < metalWorkingSkillsList.length) {
        // When removing a document, we need to mark it for removal on the server side
        // We'll set documentPath to empty string to indicate removal
        metalWorkingSkillsList[metalWorkingSkills_Edit_Index!].document = null;
        metalWorkingSkillsList[metalWorkingSkills_Edit_Index!].documentPath = '';
        metalWorkingSkillsList[metalWorkingSkills_Edit_Index!].originalName = null;
      }
    }
    // else if (type == 'vettingDocument') {
    //   _vettingInspectionDocument = null;
    //   _vettingInspectionDocumentPath = null;
    // }
  }

  // Fetch professional skills data from API
  Future<void> fetchProfessionalSkillsData(BuildContext context) async {
    try {
      String userId = NetworkHelper.loggedInUserId;
      if (userId.isEmpty) {
        print('User ID not found');
        return;
      }

      final response = await NetworkService().getResponse(
        getProfessionalSkillsByUserId + userId,
        false, // showLoading
        context,
        () => notifyListeners(),
      );

      print("Professional Skills Fetch Response: $response");

      if (response['statusCode'] == 200) {
        if (response['data'] != null && response['data'].isNotEmpty) {
          professionalSkillsData = response['data'][0]; // Get first item
          _populateFormData(professionalSkillsData!);
          print("Professional skills data loaded successfully");
        } else {
          print("No professional skills data found");
        }
      } else {
        print("Professional Skills API Error: ${response['message'] ?? 'Failed to fetch professional skills data'}");
      }
    } catch (e) {
      print("Professional Skills Fetch Exception: $e");
    }
    notifyListeners();
  }

  // Populate form data from API response
  void _populateFormData(Map<String, dynamic> data) {
    try {
      // Clear existing data
      computerAndSoftwareList.clear();
      cargoGearExperienceList.clear();
      metalWorkingSkillsList.clear();
      tankCoatingExperienceList.clear();
      portStateControlExperienceList.clear();
      
      // Reset boolean values
      cargoExperience = false;
      cargoGearExperience = false;
      metalWorkingSkills = false;
      tankCoatingExperience = false;
      portStateControlExperience = false;

      // Populate Computer and Software
      if (data['computerAndSoftware'] != null) {
        List<dynamic> computerData = data['computerAndSoftware'];
        for (var item in computerData) {
          ComputerAndSoftware computer = ComputerAndSoftware(
            software: item['software'] ?? '',
            level: item['level'] ?? '',
          );
          computerAndSoftwareList.add(computer);
        }
      }

      // Populate Cargo Experience
      if (data['cargoExperience'] != null) {
        var cargoData = data['cargoExperience'];
        cargoExperience = cargoData['hasCargoExperience'] ?? false;
        
        if (cargoData['bulkCargo'] != null) {
          bulkCargo = List<String>.from(cargoData['bulkCargo']);
        }
        if (cargoData['tankerCargo'] != null) {
          tankerCargo = List<String>.from(cargoData['tankerCargo']);
        }
        if (cargoData['generalCargo'] != null) {
          generalCargo = List<String>.from(cargoData['generalCargo']);
        }
        if (cargoData['woodProducts'] != null) {
          woodProducts = List<String>.from(cargoData['woodProducts']);
        }
        if (cargoData['stowageAndLashing'] != null) {
          stowageAndLashingExperience = List<String>.from(cargoData['stowageAndLashing']);
        }
      }

      // Populate Cargo Gear Experience
      if (data['cargoGearExperience'] != null) {
        var cargoGearData = data['cargoGearExperience'];
        cargoGearExperience = cargoGearData['hasCargoGearExperience'] ?? false;
        
        if (cargoGearData['items'] != null) {
          List<dynamic> cargoGearItems = cargoGearData['items'];
          for (var item in cargoGearItems) {
            CargoGearExperience cargoGear = CargoGearExperience(
              type: item['type'] ?? '',
              maker: item['maker'] ?? '',
              swl: item['swl'] ?? '',
            );
            cargoGearExperienceList.add(cargoGear);
          }
        }
      }

      // Populate Metal Working Skills
      if (data['metalWorkingSkills'] != null) {
        var metalWorkingData = data['metalWorkingSkills'];
        metalWorkingSkills = metalWorkingData['hasMetalWorking'] ?? false;
        
        if (metalWorkingData['items'] != null) {
          List<dynamic> metalWorkingItems = metalWorkingData['items'];
          for (var item in metalWorkingItems) {
            MetalWorkingSkill metalWorking = MetalWorkingSkill(
              skillSelection: item['skill'] ?? '',
              level: item['level'] ?? '',
              certificate: item['certificate'] ?? false,
              document: null,
              documentPath: item['fullAttachDocumentPath'] ?? '',
              originalName: item['originalName']
            );
            metalWorkingSkillsList.add(metalWorking);
          }
        }
      }

      // Populate Tank Coating Experience
      if (data['tankCoatingExperience'] != null) {
        var tankCoatingData = data['tankCoatingExperience'];
        tankCoatingExperience = tankCoatingData['hasTankCoating'] ?? false;
        
        if (tankCoatingData['items'] != null) {
          List<dynamic> tankCoatingItems = tankCoatingData['items'];
          for (var item in tankCoatingItems) {
            TankCoatingExperience tankCoating = TankCoatingExperience(
              type: item['type'] ?? '',
            );
            tankCoatingExperienceList.add(tankCoating);
          }
        }
      }

      // Populate Port State Control Experience
      if (data['portStateControlExperience'] != null) {
        var portStateData = data['portStateControlExperience'];
        portStateControlExperience = portStateData['hasPortStateControl'] ?? false;
        
        if (portStateData['items'] != null) {
          List<dynamic> portStateItems = portStateData['items'];
          for (var item in portStateItems) {
            PortStateControlExperience portState = PortStateControlExperience(
              regionalAgreement: item['regionalAgreement'] ?? '',
              port: item['port'] ?? '',
              date: item['date'] ?? '',
              observations: item['observations'] ?? '',
            );
            portStateControlExperienceList.add(portState);
          }
        }
      }

      // Populate Vetting Inspection Experience
      if (data['vettingInspectionExperience'] != null) {
        List<dynamic> vettingData = data['vettingInspectionExperience'];
        if (vettingData.isNotEmpty) {
          var vettingItem = vettingData[0]; // Get first item
          inspectionByController.text = vettingItem['inspectionBy'] ?? '';
          vettingPort = vettingItem['port'] ?? '';
          vettingDateController.text = vettingItem['date'] ?? '';
          vettingObservationsController.text = vettingItem['observations'] ?? '';
          // Handle vetting inspection document path
          // _vettingInspectionDocumentPath = vettingItem['documentPath']?.isNotEmpty == true ? vettingItem['documentPath'] : null;
        }
      }

      // Populate Trading Area Experience
      if (data['tradingAreaExperience'] != null) {
        var tradingAreaData = data['tradingAreaExperience'];
        if (tradingAreaData['tradingAreas'] != null) {
          tradingAreaExperience = List<String>.from(tradingAreaData['tradingAreas']);
        }
      }

      print("Form data populated successfully");
      print("Computer and Software: ${computerAndSoftwareList.length}");
      print("Cargo Experience: $cargoExperience");
      print("Cargo Gear Experience: $cargoGearExperience");
      print("Metal Working Skills: $metalWorkingSkills");
      print("Tank Coating Experience: $tankCoatingExperience");
      print("Port State Control Experience: $portStateControlExperience");
      print("Trading Area Experience: $tradingAreaExperience");
      
      notifyListeners();
    } catch (e) {
      print("Error populating form data: $e");
    }
  }

  // Reset form data
  void resetForm() {
    // Reset all lists
    computerAndSoftwareList.clear();
    cargoGearExperienceList.clear();
    metalWorkingSkillsList.clear();
    tankCoatingExperienceList.clear();
    portStateControlExperienceList.clear();
    
    // Reset boolean values
    cargoExperience = false;
    cargoGearExperience = false;
    metalWorkingSkills = false;
    tankCoatingExperience = false;
    portStateControlExperience = false;
    
    // Reset lists
    bulkCargo.clear();
    tankerCargo.clear();
    generalCargo.clear();
    woodProducts.clear();
    stowageAndLashingExperience.clear();
    tradingAreaExperience.clear();
    
    // Reset controllers
    inspectionByController.clear();
    vettingDateController.clear();
    vettingObservationsController.clear();
    cargoGearMakerController.clear();
    cargoGearSWLController.clear();
    dateController.clear();
    observationsController.clear();
    
    // Reset other values
    vettingPort = null;
    software = null;
    level = null;
    cargoGearType = null;
    metalWorkingSkill = null;
    metalWorkingSkillLevel = null;
    metalWorkingSkillCertificate = false;
    tankCoatingType = null;
    regionalAgreement = null;
    port = null;
    
    // Reset document attachments
    // _vettingInspectionDocument = null;
    // _vettingInspectionDocumentPath = null;
    metalWorkingSkillDocument = null;
    
    // Reset UI visibility states
    showAddSection_computerAndSoftware = false;
    showAddSection_cargoGearExperience = false;
    showAddSection_metalWorkingSkills = false;
    showAddSection_tankCoatingExperience = false;
    showAddSection_portStateControlExperience = false;
    
    // Reset edit states
    computerAndSoftware_IsEdit = false;
    computerAndSoftware_Edit_Index = null;
    cargoGearExperience_IsEdit = false;
    cargoGearExperience_Edit_Index = null;
    metalWorkingSkills_IsEdit = false;
    metalWorkingSkills_Edit_Index = null;
    tankCoatingExperience_IsEdit = false;
    tankCoatingExperience_Edit_Index = null;
    portStateControlExperience_IsEdit = false;
    portStateControlExperience_Edit_Index = null;
    
    // Reset form state
    professionalSkillsData = null;
    autovalidateMode = AutovalidateMode.disabled;
    
    notifyListeners();
  }

  // Clear only the form inputs without clearing the existing data
  void clearFormInputs() {
    // Reset form inputs only
    software = null;
    level = null;
    cargoGearType = null;
    metalWorkingSkill = null;
    metalWorkingSkillLevel = null;
    metalWorkingSkillCertificate = false;
    tankCoatingType = null;
    regionalAgreement = null;
    port = null;
    
    // Reset controllers
    inspectionByController.clear();
    vettingDateController.clear();
    vettingObservationsController.clear();
    cargoGearMakerController.clear();
    cargoGearSWLController.clear();
    dateController.clear();
    observationsController.clear();
    
    // Reset document attachments (but keep existing data)
    // _vettingInspectionDocument = null;
    metalWorkingSkillDocument = null;
    
    // Reset UI visibility states
    showAddSection_computerAndSoftware = false;
    showAddSection_cargoGearExperience = false;
    showAddSection_metalWorkingSkills = false;
    showAddSection_tankCoatingExperience = false;
    showAddSection_portStateControlExperience = false;
    
    // Reset edit states
    computerAndSoftware_IsEdit = false;
    computerAndSoftware_Edit_Index = null;
    cargoGearExperience_IsEdit = false;
    cargoGearExperience_Edit_Index = null;
    metalWorkingSkills_IsEdit = false;
    metalWorkingSkills_Edit_Index = null;
    tankCoatingExperience_IsEdit = false;
    tankCoatingExperience_Edit_Index = null;
    portStateControlExperience_IsEdit = false;
    portStateControlExperience_Edit_Index = null;
    
    // Reset form state
    autovalidateMode = AutovalidateMode.disabled;
    
    notifyListeners();
  }

  // Create or update professional skills data
  Future<bool> createOrUpdateProfessionalSkillsAPI(BuildContext context) async {
    // try {
      String userId = NetworkHelper.loggedInUserId;
      if (userId.isEmpty) {
        print('User ID not found');
        return false;
      }

      // Prepare the data object
      Map<String, dynamic> professionalSkillsPayload = {
        'userId': userId,
        'computerAndSoftware': computerAndSoftwareList.map((item) => {
          'software': item.software,
          'level': item.level,
        }).toList(),
        'cargoExperience': {
          'hasCargoExperience': cargoExperience,
          'bulkCargo': bulkCargo,
          'tankerCargo': tankerCargo,
          'generalCargo': generalCargo,
          'woodProducts': woodProducts,
          'stowageAndLashing': stowageAndLashingExperience,
        },
        'cargoGearExperience': {
          'hasCargoGearExperience': cargoGearExperience,
          'items': cargoGearExperienceList.map((item) => {
            'type': item.type,
            'maker': item.maker,
            'swl': item.swl,
          }).toList(),
        },
        'metalWorkingSkills': {
          'hasMetalWorking': metalWorkingSkills,
          'items': metalWorkingSkillsList.map((item) => {
            'skill': item.skillSelection,
            'level': item.level,
            'certificate': item.certificate,
            'documentPath': item.document?.path ?? item.documentPath ?? '',
            'originalName':item.originalName,
          }).toList(),
        },
        'tankCoatingExperience': {
          'hasTankCoating': tankCoatingExperience,
          'items': tankCoatingExperienceList.map((item) => {
            'type': item.type,
          }).toList(),
        },
        'portStateControlExperience': {
          'hasPortStateControl': portStateControlExperience,
          'items': portStateControlExperienceList.map((item) => {
            'regionalAgreement': item.regionalAgreement,
            'port': item.port,
            'date': item.date,
            'observations': item.observations,
          }).toList(),
        },
        'vettingInspectionExperience': [
          {
            'inspectionBy': inspectionByController.text,
            'port': vettingPort ?? '',
            'date': vettingDateController.text,
            'observations': vettingObservationsController.text,
            // 'documentPath': _vettingInspectionDocument?.path ?? _vettingInspectionDocumentPath ?? '',
          }
        ],
        'tradingAreaExperience': {
          'tradingAreas': tradingAreaExperience,
        },
      };

      print("Professional Skills Payload: $professionalSkillsPayload");

      // Convert data to the format expected by Dio function
      Map<String, dynamic> dioFieldData = {
        'data': jsonEncode(professionalSkillsPayload), // API expects a JSON string
      };

      // Prepare file list for metal working skills documents
      List<Map<String, dynamic>> dioFileList = [];
      
      for (int i = 0; i < metalWorkingSkillsList.length; i++) {
        var item = metalWorkingSkillsList[i];
        // Only add files that are not marked for removal
        if (item.document != null && (item.documentPath == null || item.documentPath!.isNotEmpty)) {
          dioFileList.add({
            'fieldName': 'msattachDocument[$i]',
            'filePath': item.document!.path,
            'fileName': item.document!.path.split('/').last,
          });
        }
      }

      // Add vetting inspection document if it exists
      // if (_vettingInspectionDocument != null) {
      //   dioFileList.add({
      //     'fieldName': 'vettingDocument',
      //     'filePath': _vettingInspectionDocument!.path,
      //     'fileName': _vettingInspectionDocument!.path.split('/').last,
      //   });
      // }

      print("File List: $dioFileList");

      // Make the API call
      final response = await multipartDocumentsDio(
        context,
        createOrUpdateProfessionalSkills + userId,
        dioFieldData,
        dioFileList,
         false,
      );

      print("Professional Skills Save Response: $response");

      if (response['statusCode'] == 200) {
        print("Professional skills saved successfully");
        return true;
      } else {
        print("Professional Skills Save Error: ${response['message'] ?? 'Failed to save professional skills'}");
        return false;
      }
    // } catch (e) {
    //   print("Professional Skills Save Exception: $e");
    //   return false;
    // }
  }
  
  @override
  void dispose() {
    // Dispose all FocusNodes
    cargoGearMakerFocusNode.dispose();
    cargoGearSWLFocusNode.dispose();
    dateFocusNode.dispose();
    observationsFocusNode.dispose();
    inspectionByFocusNode.dispose();
    vettingDateFocusNode.dispose();
    vettingObservationsFocusNode.dispose();
    
    // Dispose all TextEditingControllers
    cargoGearMakerController.dispose();
    cargoGearSWLController.dispose();
    dateController.dispose();
    observationsController.dispose();
    inspectionByController.dispose();
    vettingDateController.dispose();
    vettingObservationsController.dispose();
    
    super.dispose();
  }
}

class ComputerAndSoftware {
  final String software;
  final String level;

  ComputerAndSoftware({required this.software, required this.level});
}

class CargoGearExperience {
  final String type;
  final String maker;
  final String swl;

  CargoGearExperience(
      {required this.type, required this.maker, required this.swl});
}

class MetalWorkingSkill {
  final String skillSelection;
  final String level;
  final bool certificate;
  late File? document;
  String? documentPath;
  String? originalName;

  MetalWorkingSkill({
    required this.skillSelection,
    required this.level,
    required this.certificate,
    this.document,
    this.documentPath,
    this.originalName
  });
}

class TankCoatingExperience {
  final String type;

  TankCoatingExperience({required this.type});
}

class PortStateControlExperience {
  final String regionalAgreement;
  final String port;
  final String date;
  final String observations;

  PortStateControlExperience(
      {required this.regionalAgreement,
      required this.port,
      required this.date,
      required this.observations});
}

class VettingInspectionExperience {
  final String inspectionBy;
  final String port;
  final String date;
  final String observations;

  VettingInspectionExperience(
      {required this.inspectionBy,
      required this.port,
      required this.date,
      required this.observations});
}
