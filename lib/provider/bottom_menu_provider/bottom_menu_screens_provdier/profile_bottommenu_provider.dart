import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';



import 'ProfileInfo_Model.dart'; // Import the intl package for DateFormat

class ProfileBottommenuProvider with ChangeNotifier {
  // **User Information**
  String _userName = "Andrew Ainsley";
  String _userRole = "UI/UX Designer at Paypal Inc.";
  File? _profileImage;

  // **Getters**
  String get userName => _userName;
  String get userRole => _userRole;
  File? get profileImage => _profileImage;

  // **Setters**
  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void setUserRole(String role) {
    _userRole = role;
    notifyListeners();
  }

  void setProfileImage(File? image) {
    _profileImage = image;
    notifyListeners();
  }


  getProfileInfo(){

    setContactInfo(
      name: "John Doe",
      dob: "07-Dec-1997",
      countryOfBirth: "India",
      religion: "Hindu",
      sex: "Male",
      nationality: "Indian",
      email: "test@test.com",
      mobilePhone: "+919999999999",
      directLinePhone: "+911122334455",
      homeAddress: "123 Main Street, City, Country",
      nearestAirport: "Indira Gandhi International Airport",
      onlineCommunication: [
        {
          "platform": "WhatsApp",
          "id": "+919999999999",
          "verified": "true"
        },
        {
          "platform": "Skype",
          "id": "live:john.doe",
          "verified": "false"
        }
      ],
      maritalStatus: "Married",
      numberOfChildren: "2",
      profilePhotoPath: "assets/images/profileImg.png",
    );

    setProfessionalExperience(
      positionsHeld: ["Captain", "Chief Officer"],
      vesselTypeExperience: ["Bulk Carrier", "Tanker"],
      employmentHistory: [
        {
          "companyName": "Company A",
          "position": "Captain",
          "startDate": "01-Jan-2019",
          "endDate": "05-Jun-2022",
          "responsibilities": "Responsible for the ship's operations."
        },
        {
          "companyName": "Company B",
          "position": "Chief Officer",
          "startDate": "06-Jun-2022",
          "endDate": "Present",
          "responsibilities": "Managed the deck crew and navigational duties."
        }
      ],
      references: [
        {
          "issuedBy": "Company A",
          "issuingDate": "01-Feb-2025",
          "vesselOrCompanyName": "Vessel A",
          "documentUrl": "http://example.com/reference1.pdf"
        },
        {
          "issuedBy": "Company B",
          "issuingDate": "01-Mar-2025",
          "vesselOrCompanyName": "Vessel B",
          "documentUrl": "http://example.com/reference2.pdf"
        }
      ],
    );


    setTravelDocumentsCredentials(
      seafarerRegistrationNo: "SRN123456",
      passport: {
        "passportNo": "P12345678",
        "country": "India",
        "issueDate": "07-Dec-2020",
        "expDate": "07-Dec-2027",
        "documentUrl": "http://example.com/passport.pdf",
      },
      seamanBook: {
        "seamanBookNo": "SB123456",
        "issuingCountry": "India",
        "issuingAuthority": "Indian Maritime Authority",
        "issueDate": "07-Dec-2020",
        "expDate": "07-Dec-2027",
        "neverExpire": "false", // Use "false" if Seaman's Book has an expiry
        "nationality": "Indian",
        "documentUrl": "http://example.com/seaman_book.pdf",
      },
      validSeafarerVisa: {
        "valid": "true", // Use "true" or "false"
        "issuingCountry": "USA",
        "visaNo": "VISA1234",
        "issuingDate": "07-Dec-2023",
        "expDate": "07-Dec-2027",
        "documentUrl": "http://example.com/seafarer_visa.pdf",
      },
      visa: {
        "issuingCountry": "USA",
        "visaNo": "VISA5678",
        "issuingDate": "07-Dec-2023",
        "expDate": "07-Dec-2027",
        "documentUrl": "http://example.com/visa.pdf",
      },
      residencePermit: {
        "issuingCountry": "USA",
        "permitNo": "RP123456",
        "issuingDate": "07-Dec-2023",
        "expDate": "07-Dec-2027",
        "documentUrl": "http://example.com/residence_permit.pdf",
      },
    );


    setMedicalDocuments(
      medicalFitness: [
        {
          "documentType": "PEME",
          "certificateNo": "PEME 123",
          "issuingCountry": "India",
          "issuingClinic": "Clinic A",
          "issuingDate": "07-Dec-2020",
          "expDate": "07-Dec-2025",
          "neverExpire": "false", // Use "false" if certificate has an expiry
          "documentUrl": "http://example.com/medical_fitness.pdf",
        },
        {
          "documentType": "PEME 1",
          "certificateNo": "PEME 12345",
          "issuingCountry": "India",
          "issuingClinic": "Clinic B",
          "issuingDate": "07-Dec-2022",
          "expDate": "07-Dec-2027",
          "neverExpire": "false", // Use "false" if certificate has an expiry
          "documentUrl": "http://example.com/medical_fitness.pdf",
        },
      ],
      drugAlcoholTest: [
        {
          "documentType": "PEME",
          "certificateNo": "DA12345",
          "issuingCountry": "India",
          "issuingClinic": "Clinic B",
          "issuingDate": "07-Dec-2021",
          "expDate": "07-Dec-2026",
          "documentUrl": "http://example.com/drug_alcohol_test.pdf",
        },
      ],
      vaccinationCertificates: [
        {
          "documentType": "COVID-19",
          "vaccinationCountry": "India",
          "issuingClinic": "Clinic C",
          "issuingDate": "07-Dec-2021",
          "expDate": "07-Dec-2026",
          "neverExpire": "true", // Use "true" if certificate never expires
          "documentUrl": "http://example.com/vaccination_certificate.pdf",
        },
      ],
    );

    setEducation(
        academicQualifications: [
          {
            "educationalDegree": "Bachelor of Science in Nautical Science",
            "fieldOfStudy": "Nautical Science",
            "educationalInstitution": "Marine Academy",
            "country": "India",
            "graduationDate": "10-Apr-2020",
            "documentUrl": "http://example.com/degree_certificate.pdf"
          },
          {
            "educationalDegree": "Master of Science in Marine Engineering",
            "fieldOfStudy": "Marine Engineering",
            "educationalInstitution": "National Maritime University",
            "country": "India",
            "graduationDate": "15-Jul-2022",
            "documentUrl": "http://example.com/masters_certificate.pdf"
          }
        ],
        certificationsAndTrainings: [
          {
            "certificationType": "Advanced STCW Training",
            "issuingAuthority": "Maritime Safety Council",
            "issueDate": "01-Jan-2021",
            "expiryDate": "01-Jan-2026",
            "documentUrl": "http://example.com/advanced_stcw.pdf"
          },
          {
            "certificationType": "Oil Spill Response Training",
            "issuingAuthority": "International Maritime Organization",
            "issueDate": "10-Feb-2021",
            "expiryDate": "10-Feb-2026",
            "documentUrl": "http://example.com/oil_spill_response.pdf"
          }
        ],
        languagesSpoken: [
          {
            "language": "English",
            "level": "Very Good"
          },
          {
            "language": "Hindi",
            "level": "Good"
          }
        ]
    );

    setProfessionalSkills(
        computerAndSoftwareSkills: [
          {
            "software": "Danaos",
            "level": "Very Good"
          },
          {
            "software": "Benefit",
            "level": "Good"
          }
        ],
        cargoExperience: {
          "bulkCargo": true,
          "tankerCargo": true,
          "generalCargo": false,
          "woodProducts": true,
          "stowageAndLashingExperience": true
        },
        cargoGearExperience: [
          {
            "type": "Cranes",
            "maker": "ABC Cranes",
            "swl": "50 tons"
          },
          {
            "type": "Grabs",
            "maker": "XYZ Grabs",
            "swl": "30 tons"
          }
        ],
        metalWorkingSkills: [
          {
            "skillSelection": "Arc welding",
            "level": "Intermediate",
            "certificate": "true",
            "documentUrl": "http://example.com/arc_welding_certificate.pdf"
          },
          {
            "skillSelection": "Gas welding",
            "level": "Beginner",
            "certificate": "false",
            "documentUrl": ""
          }
        ],
        tankCoatingExperience: [
          {
            "type": "Epoxy"
          },
          {
            "type": "Steel"
          }
        ],
        portStateControlExperience: [
          {
            "regionalAgreement": "USCG",
            "port": "Los Angeles",
            "date": "01-Jan-2020",
            "observations": "Inspection passed"
          },
          {
            "regionalAgreement": "AMSA",
            "port": "Sydney",
            "date": "05-Apr-2021",
            "observations": "Minor defects found"
          }
        ],
        vettingInspectionExperience: [
          {
            "inspectionBy": "Inspector A",
            "port": "Dubai",
            "date": "10-Oct-2020",
            "observations": "No issues found"
          },
          {
            "inspectionBy": "Inspector B",
            "port": "Singapore",
            "date": "15-Jan-2021",
            "observations": "Inspection completed with recommendations"
          }
        ],
        tradingAreaExperience: [
          {
            "tradingArea": "North America"
          },
          {
            "tradingArea": "South America"
          }
        ]
    );



    setJobConditionsAndPreferences(
        currentRankPosition: "Captain",
        alternateRankPosition: "Chief Officer",
        preferredVesselType: ["Bulk Carrier", "Tanker"], // Multiselect
        preferredContractType: "Voyage",
        preferredPosition: "Captain",
        manningAgency: "Other", // Option
        availability: Availability(
            currentAvailabilityStatus: "Available",
            availableFrom: "15-Jan-2025",
            minOnBoardDuration: 6, // 6 months
            maxOnBoardDuration: 12, // 12 months
            minAtHomeDuration: 1, // 1 month
            maxAtHomeDuration: 3, // 3 months
            preferredRotationPattern: "2:1", // Custom rotation pattern
            tradingAreaExclusions: ["North America", "Europe"] // Excluded trading areas
        ),
        salary: Salary(
            lastJobSalary: 50000,
            lastRankJoined: "Chief Officer",
            lastPromotedDate: "15-Jan-2025",
            currency: "USD",
            justificationDocumentUrl: "http://example.com/salary_justification.pdf",
            industryStandardSalaryCalculator: true
        )
    );

    setSecurityAndComplianceInfo(
      contactInfoSharing: true,
      dataSharing: false,
      professionalConductDeclaration: true,
    );
  }

  // **Contact Info Setters**
  PersonalInfo? ContactInfo; // Declare at class level

  // **Professional Experience Setters**
  ProfessionalExperience? experienceInfo;

  void setContactInfo({
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
  }) {
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
  Future<void> pickProfileImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _profileImage = File(pickedFile.path);
      notifyListeners();
    }
  }

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
    'Personal Information': true,
    'Professional Experience': true,
    'Travel Documents & Credentials': true,
    'Medical Documents': true,
    'Education': true,
    'Professional Skills': true,
    'Job Conditions & Preferences': true,
    'Security and Compliance': true,
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
