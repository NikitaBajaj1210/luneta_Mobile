import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:luneta/network/app_url.dart';
import 'package:luneta/network/network_helper.dart';
import 'package:luneta/network/network_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Utils/helper.dart';
import 'ProfileInfo_Model.dart'; // Import the intl package for DateFormat

class ProfileBottommenuProvider with ChangeNotifier {
  // **User Information**
  String _userName = "";
  // String _userRole = "";

  // **Getters**
  String get userName => _userName;
  // String get userRole => _userRole;

  // **Setters**
  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  // void setUserRole(String role) {
  //   _userRole = role;
  //   notifyListeners();
  // }

  Future<void> getProfileData(BuildContext context) async {
    try {
      var response = await NetworkService().getResponse(
        '$getSeafarerCompleteProfile${NetworkHelper.loggedInUserId}',
        true,
        context,
        notifyListeners,
      );

      print("PROFILE API URL $getSeafarerCompleteProfile${NetworkHelper.loggedInUserId}");
      if (response != null && response['statusCode'] == 200) {
        final data = response['data'];
        if (data != null) {
          final seafarerProfile = data['seafarerProfile'][0];
          setUserName(seafarerProfile['firstName'] + " " + seafarerProfile['lastName']);

          final onlineCommunicationRaw = seafarerProfile['onlineCommunication'];

          final onlineCommunicationList = onlineCommunicationRaw != null
              ? (onlineCommunicationRaw is String
              ? jsonDecode(onlineCommunicationRaw)
              : onlineCommunicationRaw)
              : [];

          final formattedOnlineCommunication = (onlineCommunicationList as List)
              .map((e) => {
            "platform": e['platform'].toString(),
            "id": e['id'].toString(),
            "verified": "true",
          })
              .toList();

          setContactInfo(
            name: (seafarerProfile['firstName'] ?? '') + " " + (seafarerProfile['lastName'] ?? ''),
            dob: seafarerProfile['dateOfBirth'] ?? '',
            countryOfBirth: seafarerProfile['countryOfBirth'] ?? '',
            religion: seafarerProfile['religion'] ?? '',
            sex: seafarerProfile['sex'] ?? '',
            nationality: seafarerProfile['nationality'] ?? '',
            email: seafarerProfile['contactEmail'] ?? '',
            mobilePhone: seafarerProfile['mobilePhone'] ?? '',
            directLinePhone: seafarerProfile['directLinePhone'] ?? '',
            homeAddress: seafarerProfile['homeAddress']==null?'':seafarerProfile['homeAddress']['street'] ?? '',
            nearestAirport: seafarerProfile['nearestAirport'] ?? '',
            onlineCommunication:formattedOnlineCommunication,
            maritalStatus: seafarerProfile['maritalStatus'] ?? '',
            numberOfChildren: (seafarerProfile['numberOfChildren'] ?? 0).toString(),
            profilePhotoPath: seafarerProfile['profileURl'] ?? '',
          );

          if (data['professionalExperience'] != null && data['professionalExperience'].isNotEmpty) {
            final professionalExperience = data['professionalExperience'][0];
            setProfessionalExperience(
              positionsHeld: professionalExperience['positionsHeld'] != null ? List<String>.from(professionalExperience['positionsHeld']) : [],
              vesselTypeExperience: professionalExperience['vesselTypeExperience'] != null ? List<String>.from(professionalExperience['vesselTypeExperience']) : [],
              employmentHistory: professionalExperience['employmentHistory'] != null
                  ? (professionalExperience['employmentHistory'] as List)
                  .map((e) => {
                "companyName": e['companyName'].toString(),
                "position": e['position'].toString(),
                "startDate": e['startDate'].toString(),
                "endDate": e['endDate'].toString(),
                "responsibilities": e['responsibilities'].toString(),
              })
                  .toList()
                  : [],
              references: professionalExperience['references'] != null
                  ? (professionalExperience['references'] as List)
                  .map((e) => {
                "issuedBy": e['issuedBy'].toString(),
                "issuingDate": e['issuingDate'].toString(),
                "vesselOrCompanyName": e['vesselOrCompanyName'].toString(),
                "documentUrl": e['documentPath'].toString(),
              })
                  .toList()
                  : [],
            );
          }

          if (data['jobConditions'] != null && data['jobConditions'].isNotEmpty) {
            final jobConditions = data['jobConditions'][0];
            setJobConditionsAndPreferences(
              currentRankPosition: jobConditions['currentRank'] ?? '',
              alternateRankPosition: jobConditions['alternateRank'] ?? '',
              preferredVesselType: List<String>.from(jobConditions['preferredVesselType'] ?? []),
              preferredContractType: jobConditions['preferredContractType'] ?? '',
              preferredPosition: jobConditions['preferredPosition'] ?? '',
              manningAgency: jobConditions['manningAgency'] ?? '',
              availability: Availability(
                currentAvailabilityStatus: jobConditions['currentAvailabilityStatus'] ?? '',
                availableFrom: jobConditions['availableFrom'] ?? '',
                minOnBoardDuration: int.parse(jobConditions['minOnBoardDuration']==''?'0' :jobConditions['minOnBoardDuration']??'0'),
                maxOnBoardDuration: int.parse(jobConditions['maxOnBoardDuration']==''?'0' :jobConditions['maxOnBoardDuration'] ?? '0'),
                minAtHomeDuration: int.parse(jobConditions['minAtHomeDuration']==''?'0' : jobConditions['minAtHomeDuration']?? '0'),
                maxAtHomeDuration: int.parse(jobConditions['maxAtHomeDuration']==''?'0' : jobConditions['maxAtHomeDuration'] ?? '0'),
                preferredRotationPattern: jobConditions['preferredRotationPattern'] ?? '',
                tradingAreaExclusions: [jobConditions['tradingAreaExclusions'] ?? ''],
              ),
              salary: Salary(
                lastJobSalary: (jobConditions['lastJobSalary'] ?? 0).toDouble(),
                lastRankJoined: jobConditions['rank']['rank_name'] ?? '',
                lastPromotedDate: jobConditions['lastPromotedDate'] ?? '',
                currency: jobConditions['currency'] ?? '',
                justificationDocumentUrl: jobConditions['justificationDocumentPath'] ?? '',
                industryStandardSalaryCalculator: true,
              ),
            );
          }

          if (data['securityCompliance'] != null && data['securityCompliance'].isNotEmpty) {
            final securityCompliance = data['securityCompliance'][0];
            setSecurityAndComplianceInfo(
              contactInfoSharing: securityCompliance['contactInformationSharing'] ?? false,
              dataSharing: securityCompliance['dataSharing'] ?? false,
              professionalConductDeclaration: securityCompliance['professionalConductDeclaration'] ?? false,
            );
          }else{
            setSecurityAndComplianceInfo(
              contactInfoSharing:  false,
              dataSharing: false,
              professionalConductDeclaration:  false,
            );
          }

          if (data['professionalSkills'] != null && data['professionalSkills'].isNotEmpty) {
            final professionalSkills = data['professionalSkills'][0];
            setProfessionalSkills(
              computerAndSoftwareSkills: professionalSkills['computerAndSoftware'] != null
                  ? (professionalSkills['computerAndSoftware'] as List)
                  .map((e) => {
                "software": e['software'].toString(),
                "level": e['level'].toString(),
              })
                  .toList()
                  : [],
              cargoExperience: {
                "bulkCargo": professionalSkills['cargoExperience']['hasCargoExperience'] ?? false,
                "tankerCargo": professionalSkills['cargoExperience']['hasCargoExperience'] ?? false,
                "generalCargo": professionalSkills['cargoExperience']['hasCargoExperience'] ?? false,
                "woodProducts": professionalSkills['cargoExperience']['hasCargoExperience'] ?? false,
                "stowageAndLashingExperience": professionalSkills['cargoExperience']['hasCargoExperience'] ?? false,
              },
              cargoGearExperience: professionalSkills['cargoGearExperience'] != null && professionalSkills['cargoGearExperience']['items'] != null
                  ? (professionalSkills['cargoGearExperience']['items'] as List)
                  .map((e) => {
                "type": e['type'].toString(),
                "maker": e['maker'].toString(),
                "swl": e['swl'].toString(),
              })
                  .toList()
                  : [],
              metalWorkingSkills: professionalSkills['metalWorkingSkills'] != null && professionalSkills['metalWorkingSkills']['items'] != null
                  ? (professionalSkills['metalWorkingSkills']['items'] as List)
                  .map((e) => {
                "skillSelection": e['skill'].toString(),
                "level": e['level'].toString(),
                "certificate": (e['certificate'] ?? false).toString(),
                "documentUrl": e['documentPath'].toString(),
              })
                  .toList()
                  : [],
              tankCoatingExperience: professionalSkills['tankCoatingExperience'] != null && professionalSkills['tankCoatingExperience']['items'] != null
                  ? (professionalSkills['tankCoatingExperience']['items'] as List)
                  .map((e) => {
                "type": e['type'].toString(),
              })
                  .toList()
                  : [],
              portStateControlExperience: professionalSkills['portStateControlExperience'] != null && professionalSkills['portStateControlExperience']['items'] != null
                  ? (professionalSkills['portStateControlExperience']['items'] as List)
                  .map((e) => {
                "regionalAgreement": e['regionalAgreement'].toString(),
                "port": e['port'].toString(),
                "date": e['date'].toString(),
                "observations": e['observations'].toString(),
              })
                  .toList()
                  : [],
              vettingInspectionExperience: professionalSkills['vettingInspectionExperience'] != null
                  ? (professionalSkills['vettingInspectionExperience'] as List)
                  .map((e) => {
                "inspectionBy": e['inspectionBy'].toString(),
                "port": e['port'].toString(),
                "date": e['date'].toString(),
                "observations": e['observations'].toString(),
              })
                  .toList()
                  : [],
              tradingAreaExperience: professionalSkills['tradingAreaExperience'] != null && professionalSkills['tradingAreaExperience']['tradingAreas'] != null
                  ? (professionalSkills['tradingAreaExperience']['tradingAreas'] as List)
                  .map((e) => {
                "tradingArea": e.toString(),
              })
                  .toList()
                  : [],
            );
          }

          if (data['travelDocuments'] != null && data['travelDocuments'].isNotEmpty) {
            final travelDocuments = data['travelDocuments'][0];
            setTravelDocumentsCredentials(
              seafarerRegistrationNo: travelDocuments['seafarerRegNo'] ?? '',
              passport: {
                "passportNo": travelDocuments['passportNo'] ?? '',
                "country": travelDocuments['passportCountry'] ?? '',
                "issueDate": travelDocuments['passportIssueDate'] ?? '',
                "expDate": travelDocuments['passportExpDate'] ?? '',
                "documentUrl": travelDocuments['passportDocumentPath'] ?? '',
              },
              seamanBook: {
                "seamanBookNo": travelDocuments['seamansBookNo'] ?? '',
                "issuingCountry": travelDocuments['seamansBookIssuingCountry'] ?? '',
                "issuingAuthority": travelDocuments['seamansBookIssuingAuthority'] ?? '',
                "issueDate": travelDocuments['seamansBookIssueDate'] ?? '',
                "expDate": travelDocuments['seamansBookExpDate'] ?? '',
                "neverExpire": (travelDocuments['seamansBookNeverExpire'] ?? false).toString(),
                "nationality": travelDocuments['seamansBookNationality'] ?? '',
                "documentUrl": travelDocuments['seamansBookDocumentPath'] ?? '',
              },
              validSeafarerVisa: {
                "valid": (travelDocuments['validSeafarerVisa'] ?? false).toString(),
                "issuingCountry": travelDocuments['seafarerVisaIssuingCountry'] ?? '',
                "visaNo": travelDocuments['seafarerVisaNo'] ?? '',
                "issuingDate": travelDocuments['seafarerVisaIssuingDate'] ?? '',
                "expDate": travelDocuments['seafarerVisaExpDate'] ?? '',
                "documentUrl": travelDocuments['seafarerVisaDocumentPath'] ?? '',
              },
              visa: {
                "issuingCountry": travelDocuments['visaIssuingCountry'] ?? '',
                "visaNo": travelDocuments['visaNo'] ?? '',
                "issuingDate": travelDocuments['visaIssuingDate'] ?? '',
                "expDate": travelDocuments['visaExpDate'] ?? '',
                "documentUrl": travelDocuments['visaDocumentPath'] ?? '',
              },
              residencePermit: {
                "issuingCountry": travelDocuments['residencePermitIssuingCountry'] ?? '',
                "permitNo": travelDocuments['residencePermitNo'] ?? '',
                "issuingDate": travelDocuments['residencePermitIssuingDate'] ?? '',
                "expDate": travelDocuments['residencePermitExpDate'] ?? '',
                "documentUrl": travelDocuments['residencePermitDocumentPath'] ?? '',
              },
            );
          }

          if (data['medicalDocuments'] != null && data['medicalDocuments'].isNotEmpty) {
            final medicalDocuments = data['medicalDocuments'][0];
            setMedicalDocuments(
              medicalFitness: medicalDocuments['medicalFitness'] != null
                  ? (medicalDocuments['medicalFitness'] as List)
                  .map((e) => {
                "documentType": e['documentType'].toString(),
                "certificateNo": e['certificateNo'].toString(),
                "issuingCountry": e['issuingCountry'].toString(),
                "issuingClinic": e['issuingAuthority'].toString(),
                "issuingDate": e['issuingDate'].toString(),
                "expDate": e['expDate'].toString(),
                "neverExpire": (e['neverExpire'] ?? false).toString(),
                "documentUrl": e['documentUrl'].toString(),
              })
                  .toList()
                  : [],
              drugAlcoholTest: medicalDocuments['drugAlcoholTest'] != null
                  ? (medicalDocuments['drugAlcoholTest'] as List)
                  .map((e) => {
                "documentType": e['documentType'].toString(),
                "certificateNo": e['certificateNo'].toString(),
                "issuingCountry": e['issuingCountry'].toString(),
                "issuingClinic": e['issuingAuthority'].toString(),
                "issuingDate": e['issuingDate'].toString(),
                "expDate": e['expDate'].toString(),
                "documentUrl": e['documentUrl'].toString(),
              })
                  .toList()
                  : [],
              vaccinationCertificates: medicalDocuments['vaccinationCertificates'] != null
                  ? (medicalDocuments['vaccinationCertificates'] as List)
                  .map((e) => {
                "documentType": e['documentType'].toString(),
                "vaccinationCountry": e['vaccinationCountry'].toString(),
                "issuingClinic": e['issuingAuthority'].toString(),
                "issuingDate": e['issuingDate'].toString(),
                "expDate": e['expDate'].toString(),
                "neverExpire": (e['neverExpire'] ?? false).toString(),
                "documentUrl": e['documentUrl'].toString(),
              })
                  .toList()
                  : [],
            );
          }

          if (data['education'] != null && data['education'].isNotEmpty) {
            final education = data['education'][0];
            setEducation(
              academicQualifications: education['academicQualification'] != null
                  ? (education['academicQualification'] as List)
                  .map((e) => {
                "educationalDegree": e['educationalDegree'].toString(),
                "fieldOfStudy": e['fieldOfStudy'].toString(),
                "educationalInstitution": e['educationalInstitution'].toString(),
                "country": e['country'].toString(),
                "graduationDate": e['graduationDate'].toString(),
                "documentUrl": e['degreeDocumentOriginalName'].toString(),
              })
                  .toList()
                  : [],
              certificationsAndTrainings: education['certificationsAndTrainings'] != null
                  ? (education['certificationsAndTrainings'] as List)
                  .map((e) => {
                "certificationType": e['certificationType'].toString(),
                "issuingAuthority": e['issuingAuthority'].toString(),
                "issueDate": e['issueDate'].toString(),
                "expiryDate": e['expiryDate'].toString(),
                "documentUrl": e['certificationsAndTrainingsDocumentOriginalName'].toString(),
              })
                  .toList()
                  : [],
              languagesSpoken: education['languagesSpoken'] != null
                  ? (education['languagesSpoken'] as List)
                  .map((e) => {
                "language": e['native'][0].toString(),
                "level": e['level'].toString(),
              })
                  .toList()
                  : [],
            );
          }
        }
        // if(context.mounted)stopLoading(context);
      } else {
        ShowToast("Error", response['message'] ?? "failed to fetch profile data");
        if(context.mounted)stopLoading(context);
      }
    } catch (e) {
      print("Error in getProfileData: $e");
      ShowToast("Error", "an error occurred while fetching profile data.");
      if(context.mounted)stopLoading(context);
    } finally {
      if(context.mounted)stopLoading(context);
      notifyListeners();

    }
     if(context.mounted)stopLoading(context);

    notifyListeners();
  }

  Future<void> SecurityCompliancePostApi(BuildContext context) async {
    try {

      // Create request body
      Map<String, dynamic> requestBody = {
        "userId": NetworkHelper.loggedInUserId,
        "contactInformationSharing": securityAndComplianceInfo!.contactInfoSharing,
        "dataSharing": securityAndComplianceInfo!.dataSharing,
        "professionalConductDeclaration": securityAndComplianceInfo!.professionalConductDeclaration,
      };

      String body = jsonEncode(requestBody);

      Map<String, dynamic> response = await NetworkService().postResponse(
        postUpdateCompliance,
        body,
        true, // showLoading
        context,
            () => notifyListeners(),
      );


      if (response['statusCode'] == 200 || response['statusCode'] == 201) {
        ShowToast("Success", response['message'] ?? "Compliance updated.");

      } else {
        // Handle error response
        String errorMessage = response['message'] ?? "something went wrong";
        ShowToast("Error", errorMessage);
      }
    } catch (e) {
      print("compliance update error: $e");
      ShowToast("Error", "something went wrong. Please try again.");
    }
  }


  getProfileInfo(BuildContext context) {
    getProfileData(context);
  }

  // **Contact Info Setters**
  PersonalInfo? ContactInfo; // Declare at class level

  // **Professional Experience Setters**
  ProfessionalExperience? experienceInfo;

  Future<void> setContactInfo({
    required String name,
    required String dob,
    required String countryOfBirth,
    required String religion,
    required String sex,
    required String nationality,
    required String email,
    required String mobilePhone,
    String? directLinePhone,
    required String homeAddress,
    required String nearestAirport,
    required List<Map<String, String>> onlineCommunication,
    required String maritalStatus,
    required String numberOfChildren,
    required String profilePhotoPath,
  }) async {
    ContactInfo = PersonalInfo(
      name: name,
      dob: dob, // Convert string to DateTime
      countryOfBirth: countryOfBirth,
      religion: religion,
      sex: sex,
      nationality: nationality,
      contactInfo: {
        "email": email,
        "mobilePhone": mobilePhone,
        "directLinePhone": directLinePhone ?? "",
        "homeAddress": homeAddress,
        "nearestAirport": nearestAirport,
      },
      onlineCommunication: onlineCommunication,
      maritalStatus: maritalStatus,
      numberOfChildren: int.tryParse(numberOfChildren) ?? 0,
      profilePhotoPath: profilePhotoPath,
    );
    NetworkHelper.loggedInUserProfilePicURL = profilePhotoPath;
    NetworkHelper.loggedInUserFullName = name;
    var prefs = await SharedPreferences.getInstance();
    if (profilePhotoPath != '') {
      await prefs.setString('profilePicURL', profilePhotoPath);
    }
    if (name != '') {
      await prefs.setString('fullName', name);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void setProfessionalExperience({
    required List<String> positionsHeld,
    required List<String> vesselTypeExperience,
    required List<Map<String, String>> employmentHistory,
    required List<Map<String, String>> references,
  }) {
    experienceInfo = ProfessionalExperience(
      positionsHeld: positionsHeld,
      vesselTypeExperience: vesselTypeExperience,
      employmentHistory: employmentHistory.map((e) {
        return EmploymentHistory(
          companyName: e["companyName"] ?? "",
          position: e["position"] ?? "",
          startDate: "01-Jan-2025",
          endDate: e["endDate"] ?? "",
          responsibilities: e["responsibilities"] ?? "",
        );
      }).toList(),
      references: references.map((r) {
        return Reference(
          issuedBy: r["issuedBy"] ?? "",
          issuingDate: r["issuingDate"] ?? "",
          vesselOrCompanyName: r["vesselOrCompanyName"] ?? "",
          documentUrl: r["documentUrl"] ?? "",
        );
      }).toList(),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }


  TravelDocumentsCredentials? travelDocsInfo;

  void setTravelDocumentsCredentials({
    required String seafarerRegistrationNo,
    required Map<String, String> passport,
    required Map<String, String> seamanBook,
    required Map<String, String> validSeafarerVisa,
    required Map<String, String> visa,
    required Map<String, String> residencePermit,
  }) {
    travelDocsInfo = TravelDocumentsCredentials(
      seafarerRegistrationNo: seafarerRegistrationNo,
      passport: Passport(
        passportNo: passport["passportNo"] ?? "",
        country: passport["country"] ?? "",
        issueDate: passport["issueDate"] ?? "2000-01-01",
        expDate: passport["expDate"] ?? "2000-01-01",
        documentUrl: passport["documentUrl"] ?? "",
      ),
      seamanBook: SeamanBook(
        seamanBookNo: seamanBook["seamanBookNo"] ?? "",
        issuingCountry: seamanBook["issuingCountry"] ?? "",
        issuingAuthority: seamanBook["issuingAuthority"] ?? "",
        issueDate: seamanBook["issueDate"] ?? "2000-01-01",
        expDate: seamanBook["expDate"] ?? "2000-01-01",
        neverExpire: seamanBook["neverExpire"] == "true",
        nationality: seamanBook["nationality"] ?? "",
        documentUrl: seamanBook["documentUrl"] ?? "",
      ),
      validSeafarerVisa: SeafarerVisa(
        valid: validSeafarerVisa["valid"] == "true",
        issuingCountry: validSeafarerVisa["issuingCountry"] ?? "",
        visaNo: validSeafarerVisa["visaNo"] ?? "",
        issuingDate: validSeafarerVisa["issuingDate"] ?? "2000-01-01",
        expDate: validSeafarerVisa["expDate"] ?? "2000-01-01",
        documentUrl: validSeafarerVisa["documentUrl"] ?? "",
      ),
      visa: Visa(
        issuingCountry: visa["issuingCountry"] ?? "",
        visaNo: visa["visaNo"] ?? "",
        issuingDate: visa["issuingDate"] ?? "2000-01-01",
        expDate: visa["expDate"] ?? "2000-01-01",
        documentUrl: visa["documentUrl"] ?? "",
      ),
      residencePermit: ResidencePermit(
        issuingCountry: residencePermit["issuingCountry"] ?? "",
        permitNo: residencePermit["permitNo"] ?? "",
        issuingDate: residencePermit["issuingDate"] ?? "2000-01-01",
        expDate: residencePermit["expDate"] ?? "2000-01-01",
        documentUrl: residencePermit["documentUrl"] ?? "",
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }


  MedicalDocuments? medicalDocsInfo;

  void setMedicalDocuments({
    required List<Map<String, String>> medicalFitness,
    required List<Map<String, String>> drugAlcoholTest,
    required List<Map<String, String>> vaccinationCertificates,
  }) {
    medicalDocsInfo = MedicalDocuments(
      medicalFitness: medicalFitness.map((m) {
        return MedicalFitness(
          documentType: m["documentType"] ?? "",
          certificateNo: m["certificateNo"] ?? "",
          issuingCountry: m["issuingCountry"] ?? "",
          issuingClinic: m["issuingClinic"] ?? "",
          issuingDate: m["issuingDate"] ?? "2000-01-01",
          expDate: m["expDate"] ?? "2000-01-01",
          neverExpire: m["neverExpire"] == "true", // If the certificate never expires
          documentUrl: m["documentUrl"] ?? "",
        );
      }).toList(),
      drugAlcoholTest: drugAlcoholTest.map((d) {
        return DrugAlcoholTest(
          documentType: d["documentType"] ?? "",
          certificateNo: d["certificateNo"] ?? "",
          issuingCountry: d["issuingCountry"] ?? "",
          issuingClinic: d["issuingClinic"] ?? "",
          issuingDate: d["issuingDate"] ?? "2000-01-01",
          expDate: d["expDate"] ?? "2000-01-01",
          documentUrl: d["documentUrl"] ?? "",
        );
      }).toList(),
      vaccinationCertificates: vaccinationCertificates.map((v) {
        return VaccinationCertificate(
          documentType: v["documentType"] ?? "",
          vaccinationCountry: v["vaccinationCountry"] ?? "",
          issuingClinic: v["issuingClinic"] ?? "",
          issuingDate: v["issuingDate"] ?? "2000-01-01",
          expDate: v["expDate"] ?? "2000-01-01",
          neverExpire: v["neverExpire"] == "true", // If the certificate never expires
          documentUrl: v["documentUrl"] ?? "",
        );
      }).toList(),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }


  Education? educationInfo;
  ProfessionalSkills? professionalSkillsInfo;
  JobConditionsAndPreferences? jobConditionsAndPreferencesInfo;

  void setEducation({
    required List<Map<String, String>> academicQualifications,
    required List<Map<String, String>> certificationsAndTrainings,
    required List<Map<String, String>> languagesSpoken,
  }) {
    educationInfo = Education(
      academicQualifications: academicQualifications.map((e) {
        return AcademicQualification(
          educationalDegree: e["educationalDegree"] ?? "",
          fieldOfStudy: e["fieldOfStudy"] ?? "",
          educationalInstitution: e["educationalInstitution"] ?? "",
          country: e["country"] ?? "",
          graduationDate:e["graduationDate"] ?? '2000-01-01',
          documentUrl: e["documentUrl"] ?? "",
        );
      }).toList(),
      certificationsAndTrainings: certificationsAndTrainings.map((e) {
        return CertificationTraining(
          certificationType: e["certificationType"] ?? "",
          issuingAuthority: e["issuingAuthority"] ?? "",
          issueDate: e["issueDate"] ?? '2000-01-01',
          expiryDate: e["expiryDate"] ?? '2000-01-01',
          documentUrl: e["documentUrl"] ?? "",
        );
      }).toList(),
      languagesSpoken: languagesSpoken.map((e) {
        return Language(
          language: e["language"] ?? "",
          level: e["level"] ?? "",
        );
      }).toList(),
    );
  }

  void setProfessionalSkills({
    required List<Map<String, String>> computerAndSoftwareSkills,
    required Map<String, bool> cargoExperience,
    required List<Map<String, String>> cargoGearExperience,
    required List<Map<String, String>> metalWorkingSkills,
    required List<Map<String, String>> tankCoatingExperience,
    required List<Map<String, String>> portStateControlExperience,
    required List<Map<String, String>> vettingInspectionExperience,
    required List<Map<String, String>> tradingAreaExperience,
  }) {
    professionalSkillsInfo = ProfessionalSkills(
      computerAndSoftwareSkills: computerAndSoftwareSkills.map((e) {
        return ComputerSoftware(
          software: e["software"] ?? "",
          level: e["level"] ?? "",
        );
      }).toList(),
      cargoExperience: CargoExperience(
        bulkCargo: cargoExperience["bulkCargo"] ?? false,
        tankerCargo: cargoExperience["tankerCargo"] ?? false,
        generalCargo: cargoExperience["generalCargo"] ?? false,
        woodProducts: cargoExperience["woodProducts"] ?? false,
        stowageAndLashingExperience: cargoExperience["stowageAndLashingExperience"] ?? false,
      ),
      cargoGearExperience: cargoGearExperience.map((e) {
        return CargoGearExperience(
          type: e["type"] ?? "",
          maker: e["maker"] ?? "",
          swl: e["swl"] ?? "",
        );
      }).toList(),
      metalWorkingSkills: metalWorkingSkills.map((e) {
        return MetalWorkingSkill(
          skillSelection: e["skillSelection"] ?? "",
          level: e["level"] ?? "",
          certificate: e["certificate"] == "true",
          documentUrl: e["documentUrl"] ?? "",
        );
      }).toList(),
      tankCoatingExperience: tankCoatingExperience.map((e) {
        return TankCoatingExperience(
          type: e["type"] ?? "",
        );
      }).toList(),
      portStateControlExperience: portStateControlExperience.map((e) {
        return PortStateControlExperience(
          regionalAgreement: e["regionalAgreement"] ?? "",
          port: e["port"] ?? "",
          date: e["date"] ?? '2000-01-01',
          observations: e["observations"] ?? "",
        );
      }).toList(),
      vettingInspectionExperience: vettingInspectionExperience.map((e) {
        return VettingInspectionExperience(
          inspectionBy: e["inspectionBy"] ?? "",
          port: e["port"] ?? "",
          date: e["date"] ?? '2000-01-01',
          observations: e["observations"] ?? "",
        );
      }).toList(),
      tradingAreaExperience: tradingAreaExperience.map((e) {
        return TradingAreaExperience(
          tradingArea: e["tradingArea"] ?? "",
        );
      }).toList(),
    );
  }

  void setJobConditionsAndPreferences({
    required String currentRankPosition,
    required String alternateRankPosition,
    required List<String> preferredVesselType,
    required String preferredContractType,
    required String preferredPosition,
    required String manningAgency,
    required Availability availability,
    required Salary salary,
  }) {
    jobConditionsAndPreferencesInfo = JobConditionsAndPreferences(
      currentRankPosition: currentRankPosition,
      alternateRankPosition: alternateRankPosition,
      preferredVesselType: preferredVesselType,
      preferredContractType: preferredContractType,
      preferredPosition: preferredPosition,
      manningAgency: manningAgency,
      availability: availability,
      salary: salary,
    );
  }


  // Security and Compliance Information
  SecurityAndComplianceInfo? securityAndComplianceInfo;

  // Initialize the data
  void setSecurityAndComplianceInfo({
    required bool contactInfoSharing,
    required bool dataSharing,
    required bool professionalConductDeclaration,
  }) {
    securityAndComplianceInfo = SecurityAndComplianceInfo(
      contactInfoSharing: contactInfoSharing,
      dataSharing: dataSharing,
      professionalConductDeclaration: professionalConductDeclaration,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  // **Summary Information**
  String? _summary;
  String? get summary => _summary;

  void setSummary(String summary) {
    _summary = summary;
    notifyListeners();
  }

  // **Expected Salary Information**
  String? _expectedSalaryMin;
  String? _expectedSalaryMax;
  String? _salaryFrequency;
  bool _expectedSalary = false;

  // **Expected Salary Getters**
  String? get expectedSalaryMin => _expectedSalaryMin;
  String? get expectedSalaryMax => _expectedSalaryMax;
  String? get salaryFrequency => _salaryFrequency;
  bool get expectedSalary => _expectedSalary;

  // **Expected Salary Setter**
  void setExpectedSalary({required String min, required String max, required String frequency}) {
    _expectedSalaryMin = min;
    _expectedSalaryMax = max;
    _salaryFrequency = frequency.toLowerCase();
    _expectedSalary = true;
    notifyListeners();
  }

  // **Work Experience Information**
  List<Map<String, dynamic>> _workExperiences = [];

  // **Work Experience Getters**
  List<Map<String, dynamic>> get workExperiences => _workExperiences;

  // **Work Experience Methods**
  void addWorkExperience({
    required String title,
    required String company,
    required String startDate,
    required String endDate,
    String? location,
    String? description,
    String? employmentType,
    String? jobLevel,
    String? jobFunction,
  }) {
    // Parse dates to calculate duration
    DateTime start = DateFormat('MM/yyyy').parse(startDate);
    DateTime end = endDate == 'Present' ? DateTime.now() : DateFormat('MM/yyyy').parse(endDate);
    
    // Calculate duration
    int months = (end.year - start.year) * 12 + end.month - start.month;
    String duration;
    if (months < 12) {
      duration = '$months month${months > 1 ? 's' : ''}';
    } else {
      int years = months ~/ 12;
      int remainingMonths = months % 12;
      if (remainingMonths == 0) {
        duration = '$years year${years > 1 ? 's' : ''}';
      } else {
        duration = '$years year${years > 1 ? 's' : ''} $remainingMonths month${remainingMonths > 1 ? 's' : ''}';
      }
    }

    _workExperiences.add({
      'title': title,
      'company': company,
      'startDate': startDate,
      'endDate': endDate,
      'duration': duration,
      'location': location,
      'description': description,
      'employmentType': employmentType,
      'jobLevel': jobLevel,
      'jobFunction': jobFunction,
      'companyLogo': company.toLowerCase().contains('paypal') ? 'assets/images/paypal.png' :
                   company.toLowerCase().contains('pinterest') ? 'assets/images/pinterest.png' :
                   company.toLowerCase().contains('dribbble') ? 'assets/images/dribbble.png' :
                   'assets/images/default_company.png',
    });
    notifyListeners();
  }

  // Update existing work experience
  void updateWorkExperience(int index, Map<String, dynamic> updatedData) {
    if (index >= 0 && index < _workExperiences.length) {
      // Preserve the company logo
      updatedData['companyLogo'] = _workExperiences[index]['companyLogo'];
      
      // Update the work experience at the given index
      _workExperiences[index] = updatedData;
      notifyListeners();
    }
  }

  // **Duration Calculation**
  String _calculateDuration(String startDate, String? endDate, {bool includeParentheses = true}) {
    try {
      final start = DateFormat('MMM yyyy').parse(startDate);
      final end = endDate != null ? DateFormat('MMM yyyy').parse(endDate) : DateTime.now();
      
      final months = (end.year - start.year) * 12 + end.month - start.month;
      
      String duration;
      if (months == 1) {
        duration = '1 month';
      } else {
        duration = '$months months';
      }
      
      return includeParentheses ? '($duration)' : duration;
    } catch (e) {
      print('Error calculating duration: $e');
      return '';
    }
  }

  // **Education Information**
  List<Map<String, dynamic>> _educations = [];

  // **Education Getters**
  List<Map<String, dynamic>> get educations => _educations;

  // **Education Methods**
  void addEducation({
    required String degree,
    required String course,
    required String school,
    required String startDate,
    required String endDate,
    String? gpa,
    String? scale,
    String? description,
  }) {
    final duration = _calculateDuration(startDate, endDate, includeParentheses: false);
    
    _educations.add({
      'degree': degree,
      'course': course,
      'school': school,
      'startDate': startDate,
      'endDate': endDate,
      'duration': duration,
      'gpa': gpa,
      'scale': scale,
      'description': description,
      'schoolLogo': 'assets/images/companyLogo.png',
    });
    notifyListeners();
  }

  void updateEducation(int index, Map<String, dynamic> updatedData) {
    if (index >= 0 && index < _educations.length) {
      final duration = _calculateDuration(
        updatedData['startDate'] ?? _educations[index]['startDate'],
        updatedData['endDate'] ?? _educations[index]['endDate'],
        includeParentheses: false
      );

      _educations[index] = {
        'degree': updatedData['degree'] ?? _educations[index]['degree'],
        'course': updatedData['course'] ?? _educations[index]['course'],
        'school': updatedData['school'] ?? _educations[index]['school'],
        'startDate': updatedData['startDate'] ?? _educations[index]['startDate'],
        'endDate': updatedData['endDate'] ?? _educations[index]['endDate'],
        'duration': duration,
        'gpa': updatedData['gpa'] ?? _educations[index]['gpa'],
        'scale': updatedData['scale'] ?? _educations[index]['scale'],
        'description': updatedData['description'] ?? _educations[index]['description'],
        'schoolLogo': 'assets/images/companyLogo.png',
      };
      notifyListeners();
    }
  }

  // **Projects Information**
  List<Map<String, dynamic>> _projects = [];

  // **Projects Getters**
  List<Map<String, dynamic>> get projects => _projects;

  // **Projects Methods**
  void addProject({
    required String title,
    required String role,
    required String startDate,
    required String endDate,
    String? associatedWith,
    String? description,
    String? projectUrl,
  }) {
    final duration = _calculateDuration(startDate, endDate, includeParentheses: false);

    _projects.add({
      'title': title,
      'role': role,
      'startDate': startDate,
      'endDate': endDate,
      'duration': duration,
      'projectLogo': 'assets/images/bagIcon.png',
      'associatedWith': associatedWith,
      'description': description,
      'projectUrl': projectUrl,
    });
    notifyListeners();
  }

  // **Certifications**
  final List<Map<String, dynamic>> _certifications = [];
  List<Map<String, dynamic>> get certifications => _certifications;

  void addCertification({
    required String title,
    required String organization,
    required String issueDate,
    String? expirationDate,
    required bool noExpiry,
    String? credentialId,
    String? credentialUrl,
  }) {
    _certifications.add({
      'title': title,
      'organization': organization,
      'issueDate': issueDate,
      'expirationDate': expirationDate,
      'noExpiry': noExpiry,
      'credentialId': credentialId,
      'credentialUrl': credentialUrl,
    });
    
    // Mark the certifications section as completed
    setSectionStatus("Certification and Licenses", true);
    notifyListeners();
  }

  void removeCertification(int index) {
    if (index >= 0 && index < _certifications.length) {
      _certifications.removeAt(index);
      notifyListeners();
    }
  }

  void updateCertification(int index, Map<String, dynamic> updatedData) {
    if (index >= 0 && index < _certifications.length) {
      _certifications[index] = updatedData;
      notifyListeners();
    }
  }

  // **Volunteering**
  final List<Map<String, dynamic>> _volunteering = [];
  List<Map<String, dynamic>> get volunteering => _volunteering;

  void addVolunteering({
    required String title,
    required String organization,
    required String startDate,
    String? endDate,
    required bool currentlyWorking,
    String? role,
    String? description,
    String? websiteUrl,
  }) {
    final duration = _calculateDuration(startDate, endDate);
    final displayDate = '$startDate - ${endDate ?? 'Present'} $duration';

    _volunteering.add({
      'title': title,
      'organization': organization,
      'displayDate': displayDate,
      'startDate': startDate,
      'endDate': endDate,
      'currentlyWorking': currentlyWorking,
      'role': role,
      'description': description,
      'websiteUrl': websiteUrl,
    });
    
    // Mark the volunteering section as completed
    setSectionStatus("Volunteering Experience", true);
    notifyListeners();
  }

  void removeVolunteering(int index) {
    if (index >= 0 && index < _volunteering.length) {
      _volunteering.removeAt(index);
      notifyListeners();
    }
  }

  void updateVolunteering(int index, Map<String, dynamic> updatedData) {
    if (index >= 0 && index < _volunteering.length) {
      _volunteering[index] = updatedData;
      notifyListeners();
    }
  }

  // **Professional Exams**
  final List<Map<String, dynamic>> _professionalExams = [];
  List<Map<String, dynamic>> get professionalExams => _professionalExams;

  void addProfessionalExam({
    required String examName,
    required String score,
    required String date,
  }) {
    _professionalExams.add({
      'examName': examName,
      'score': score,
      'date': date,
      'icon': examName.toLowerCase().contains('ielts') ? 'assets/images/IELTS.png' :
              examName.toLowerCase().contains('toefl') ? 'assets/images/IELTS.png' :
              'assets/images/IELTS.png',
    });
    
    // Mark the professional exams section as completed
    setSectionStatus("Professional Exams", true);
    notifyListeners();
  }

  void removeProfessionalExam(int index) {
    _professionalExams.removeAt(index);
    if (_professionalExams.isEmpty) {
      setSectionStatus("Professional Exams", false);
    }
    notifyListeners();
  }

  // **Awards & Achievements**
  final List<Map<String, dynamic>> _awards = [];
  List<Map<String, dynamic>> get awards => _awards;

  void addAward({
    required String title,
    required String issuer,
    required String date,
  }) {
    _awards.add({
      'title': title,
      'issuer': issuer,
      'date': date,
      'icon': title.toLowerCase().contains('google') ? 'assets/images/GoogleIcon.png' :
              title.toLowerCase().contains('twitter') ? 'assets/images/TwitterIcon.png' :
              'assets/images/TwitterIcon.png',
    });
    
    // Mark the awards section as completed
    setSectionStatus("Awards & Achievements", true);
    notifyListeners();
  }



  List<Map<String, dynamic>> _seminarsTrainings = [];

  List<Map<String, dynamic>> get seminarsTrainings => _seminarsTrainings;

  // Add seminar/training
  void addSeminarTraining({
    required String title,
    required String organization,
    required String displayDate,
    String? description,
  }) {
    _seminarsTrainings.add({
      'title': title,
      'organization': organization,
      'displayDate': displayDate,
      'description': description,
    });
    setSectionStatus("Seminars & Trainings", true);
    notifyListeners();
    // Notify listeners to update UI
  }

  List<Map<String, dynamic>> _affiliationData = [];

  List<Map<String, dynamic>> get affiliationData => _affiliationData;

  // Add seminar/training
  void addAffiliationData({
    required String title,
    required String organization,
    required String displayDate,
    String? description,
  }) {
    _affiliationData.add({
      'title': title,
      'organization': organization,
      'displayDate': displayDate,
      'description': description,
    });
    setSectionStatus("Affiliations", true);
    notifyListeners();
    // Notify listeners to update UI
  }

  List<Map<String, dynamic>> _organizationActivities = [];

  List<Map<String, dynamic>> get organizationActivities => _organizationActivities;



  // **Add Organization Activity**
  void addOrganizationActivity({
    required String organization,
    required String role,
    required DateTime fromDate,
    required DateTime toDate,
    required bool stillMember,
    String? description,
  }) {
    // Convert DateTime to String in the required format
    final fromDateString = DateFormat("MMM yyyy").format(fromDate);
    final toDateString = DateFormat("MMM yyyy").format(toDate);

    // Calculate the duration, now using the String values
    final duration = _calculateDuration(fromDateString, toDateString, includeParentheses: true);

    // Format the display date
    final displayDate = '$fromDateString - ${stillMember ? 'Present' : toDateString} $duration';

    // Add to the organization activities list
    _organizationActivities.add({
      'organization': organization,
      'role': role,
      'fromDate': fromDate,
      'toDate': toDate,
      'stillMember': stillMember,
      'description': description,
      'displayDate': displayDate,  // Store the formatted date with duration
    });

    // Mark the section as completed
    setSectionStatus("Organization Activities", true);
    notifyListeners();
  }

  void removeAward(int index) {
    _awards.removeAt(index);
    if (_awards.isEmpty) {
      setSectionStatus("Awards & Achievements", false);
    }
    notifyListeners();
  }

  // **Languages Information**
  List<Map<String, String>> _languages = [];

  // **Languages Getters**
  List<Map<String, String>> get languages => _languages;

  // **Languages Methods**
  void addLanguage({
    required String language,
    required String proficiency,
  }) {
    _languages.add({
      'language': language,
      'proficiency': proficiency,
    });
    setSectionStatus("Languages", true); // Ensure the section is enabled
    notifyListeners();
  }

  // **Skills Information**
  List<String> _skills = [];

  // **Skills Getters**
  List<String> get skills => _skills;

  // **Skills Methods**
  void setSkills(List<String> skills) {
    _skills = skills;
    setSectionStatus("Skills", true); // Ensure the section is enabled
    notifyListeners();
  }

  // **Function to Pick Profile Image**
  // Future<void> pickProfileImage() async {
  //   final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     _profileImage = File(pickedFile.path);
  //     notifyListeners();
  //   }
  // }

  // **Existing Profile Sections**
  final List<Map<String, dynamic>> _profileSections = [
    {"title": "Personal Information", "icon": "assets/images/profileActive.png"},
    {"title": "Professional Experience", "icon": "assets/images/DocumentIcon.png"},
    {"title": "Travel Documents & Credentials", "icon": "assets/images/SalaryChart.png"},
    {"title": "Medical Documents", "icon": "assets/images/WorkActive.png"},
    {"title": "Education", "icon": "assets/images/Paper.png"},
    {"title": "Professional Skills", "icon": "assets/images/Chart.png"},
    {"title": "Job Conditions & Preferences", "icon": "assets/images/TicketStar.png"},
    {"title": "Security and Compliance", "icon": "assets/images/2User.png"},
  ];


  // **Getter for Profile Sections**
  List<Map<String, dynamic>> get profileSections => List.unmodifiable(_profileSections);

  // **Section Status**
  Map<String, bool> _sectionStatus = {
    'Personal Information': false,
    'Professional Experience': false,
    'Travel Documents & Credentials': false,
    'Medical Documents': false,
    'Education': false,
    'Professional Skills': false,
    'Job Conditions & Preferences': false,
    'Security and Compliance': false,
  };


  // **Section Status Getters and Setters**
  bool getSectionStatus(String section) => _sectionStatus[section] ?? false;
  
  void setSectionStatus(String section, bool status) {
    _sectionStatus[section] = status;
    notifyListeners();
  }

  // **Available Icons for Selection**
  final List<String> availableIcons = [
    "assets/images/profileActive.png",
    "assets/images/DocumentIcon.png",
    "assets/images/SalaryChart.png",
    "assets/images/WorkActive.png",
    "assets/images/Paper.png",
    "assets/images/Chart.png",
    "assets/images/TicketStar.png",
    "assets/images/Star.png",
  ];

  String? selectedIcon;

  // **Set Selected Icon**
  void setSelectedIcon(String icon) {
    selectedIcon = icon;
    notifyListeners();
  }

  // **Function to Add Custom Section**
  void addCustomSection(String title, String icon) {
    if (title.isNotEmpty && icon.isNotEmpty) {
      _profileSections.add({"title": title, "icon": icon});
      notifyListeners();
    }
  }

  // **References Information**
  List<Map<String, String>> _references = [];

  // **References Getters**
  List<Map<String, String>> get references => _references;

  // **References Methods**
  void addReference({
    required String name,
    required String company,
    required String occupation,
    required String email,
    required String phoneNumber,
  }) {
    _references.add({
      'name': name,
      'company': company,
      'occupation': occupation,
      'email': email,
      'phoneNumber': phoneNumber,
    });
    setSectionStatus("References", true);
    notifyListeners();
  }

  // **CV/Resume Information**
  File? _cvResume;

  // **CV/Resume Getter**
  File? get cvResume => _cvResume;

  // **CV/Resume Setter**
  void setCVResume(File? file) {
    _cvResume = file;
    setSectionStatus("CV/Resume", true);
    notifyListeners();
  }

  void removeCVResume() {
    _cvResume = null;
    setSectionStatus("CV/Resume", false);
    notifyListeners();
  }


}
