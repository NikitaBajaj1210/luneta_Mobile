import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

class ProfessionalSkillsProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

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
    }
  }

  void editComputerAndSoftware(int index) {
    computerAndSoftware_Edit_Index = index;
    computerAndSoftware_IsEdit = true;
    software = computerAndSoftwareList[index].software;
    level = computerAndSoftwareList[index].level;
    setComputerAndSoftwareVisibility(true);
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

  // Cargo Experience
  bool cargoExperience = false;
  List<String> bulkCargo = [];
  List<String> tankerCargo = [];
  List<String> generalCargo = [];
  List<String> woodProducts = [];
  List<String> stowageAndLashingExperience = [];

  List<String> bulkCargoList = ["Grain", "Sugar", "Coal"];
  List<String> tankerCargoList = ["LNG", "LPG", "Gasoline"];
  List<String> generalCargoList = ["Steel", "Granite blocks"];
  List<String> woodProductsList = ["Timber", "Paper rolls"];
  List<String> stowageAndLashingExperienceList = ["General", "Steel"];

  void setCargoExperience(bool value) {
    cargoExperience = value;
    notifyListeners();
  }

  // Cargo Gear Experience
  bool cargoGearExperience = false;
  List<CargoGearExperience> cargoGearExperienceList = [];
  bool showAddSection_cargoGearExperience = false;
  int? cargoGearExperience_Edit_Index;
  bool cargoGearExperience_IsEdit = false;
  String? cargoGearType;
  final cargoGearMakerController = TextEditingController();
  final cargoGearSWLController = TextEditingController();
  List<String> cargoGearTypes = ["Cranes", "Grabs"];

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
    if (!value) {
      cargoGearType = null;
      cargoGearMakerController.clear();
      cargoGearSWLController.clear();
      cargoGearExperience_IsEdit = false;
      cargoGearExperience_Edit_Index = null;
    }
    notifyListeners();
  }

  // Metal Working Skills
  bool metalWorkingSkills = false;
  List<MetalWorkingSkill> metalWorkingSkillsList = [];
  bool showAddSection_metalWorkingSkills = false;
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
  List<String> metalWorkingSkillLevelList = ["Beginner", "Intermediate"];

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

  void addMetalWorkingSkill() {
    if (metalWorkingSkill != null && metalWorkingSkillLevel != null) {
      if (metalWorkingSkills_IsEdit) {
        metalWorkingSkillsList[metalWorkingSkills_Edit_Index!] =
            MetalWorkingSkill(
                skillSelection: metalWorkingSkill!,
                level: metalWorkingSkillLevel!,
                certificate: metalWorkingSkillCertificate,
                document: metalWorkingSkillDocument);
      } else {
        metalWorkingSkillsList.add(MetalWorkingSkill(
            skillSelection: metalWorkingSkill!,
            level: metalWorkingSkillLevel!,
            certificate: metalWorkingSkillCertificate,
            document: metalWorkingSkillDocument));
      }
      setMetalWorkingSkillsVisibility(false);
    }
  }

  void editMetalWorkingSkill(int index) {
    metalWorkingSkills_Edit_Index = index;
    metalWorkingSkills_IsEdit = true;
    metalWorkingSkill = metalWorkingSkillsList[index].skillSelection;
    metalWorkingSkillLevel = metalWorkingSkillsList[index].level;
    metalWorkingSkillCertificate = metalWorkingSkillsList[index].certificate;
    metalWorkingSkillDocument = metalWorkingSkillsList[index].document;
    setMetalWorkingSkillsVisibility(true);
  }

  void removeMetalWorkingSkill(int index) {
    metalWorkingSkillsList.removeAt(index);
    notifyListeners();
  }

  void setMetalWorkingSkillsVisibility(bool value) {
    showAddSection_metalWorkingSkills = value;
    if (!value) {
      metalWorkingSkill = null;
      metalWorkingSkillLevel = null;
      metalWorkingSkillCertificate = false;
      metalWorkingSkillDocument = null;
      metalWorkingSkills_IsEdit = false;
      metalWorkingSkills_Edit_Index = null;
    }
    notifyListeners();
  }

  // Tank Coating Experience
  bool tankCoatingExperience = false;
  List<TankCoatingExperience> tankCoatingExperienceList = [];
  bool showAddSection_tankCoatingExperience = false;
  int? tankCoatingExperience_Edit_Index;
  bool tankCoatingExperience_IsEdit = false;
  String? tankCoatingType;
  List<String> tankCoatingTypes = ["Epoxy", "Steel", "Stainless steel"];

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
    if (!value) {
      tankCoatingType = null;
      tankCoatingExperience_IsEdit = false;
      tankCoatingExperience_Edit_Index = null;
    }
    notifyListeners();
  }

  // Port State Control Experience
  bool portStateControlExperience = false;
  List<PortStateControlExperience> portStateControlExperienceList = [];
  bool showAddSection_portStateControlExperience = false;
  int? portStateControlExperience_Edit_Index;
  bool portStateControlExperience_IsEdit = false;
  String? regionalAgreement;
  String? port;
  final dateController = TextEditingController();
  final observationsController = TextEditingController();
  List<String> regionalAgreements = ["USCG", "AMSA", "China Federation"];
  List<String> ports = ["New York", "Los Angeles", "Shanghai"];

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
    if (!value) {
      regionalAgreement = null;
      port = null;
      dateController.clear();
      observationsController.clear();
      portStateControlExperience_IsEdit = false;
      portStateControlExperience_Edit_Index = null;
    }
    notifyListeners();
  }

  // Vetting Inspection Experience
  final inspectionByController = TextEditingController();
  String? vettingPort;
  final vettingDateController = TextEditingController();
  final vettingObservationsController = TextEditingController();
  List<String> vettingPorts = ["New York", "Los Angeles", "Shanghai"];

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
  List<String> tradingAreaList = ["Worldwide", "Europe", "Asia"];

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
                  _pickImage(ImageSource.gallery, type);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Take a picture'),
                onTap: () {
                  _pickImage(ImageSource.camera, type);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.description),
                title: Text('Choose a document'),
                onTap: () {
                  _pickDocument(type);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickDocument(String type) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      final file = File(result.files.single.path!);
      if (type == 'metalWorkingSkill') {
        setMetalWorkingSkillDocument(file);
      }
    }
  }

  Future<void> _pickImage(ImageSource source, String type) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      if (type == 'metalWorkingSkill') {
        setMetalWorkingSkillDocument(file);
      }
    }
  }

  void removeAttachment(String type) {
    if (type == 'metalWorkingSkill') {
      setMetalWorkingSkillDocument(null);
    }
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
  final File? document;

  MetalWorkingSkill(
      {required this.skillSelection,
      required this.level,
      required this.certificate,
      this.document});
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
