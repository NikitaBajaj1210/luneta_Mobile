
// PersonalInfo
class PersonalInfo {
  String name;
  String dob;
  String countryOfBirth;
  String religion;
  String sex;
  String nationality;
  Map<String, dynamic> contactInfo;
  List<Map<String, String>> onlineCommunication;
  String maritalStatus;
  int numberOfChildren;
  String profilePhotoPath;

  PersonalInfo({
    required this.name,
    required this.dob,
    required this.countryOfBirth,
    required this.religion,
    required this.sex,
    required this.nationality,
    required this.contactInfo,
    required this.onlineCommunication,
    required this.maritalStatus,
    required this.numberOfChildren,
    required this.profilePhotoPath,
  });
}


// ProfessionalExperience
class ProfessionalExperience {
  List<String> positionsHeld; // List of positions held
  List<String> vesselTypeExperience; // List of vessel types experienced
  List<EmploymentHistory> employmentHistory; // Employment history list
  List<Reference> references; // References list

  ProfessionalExperience({
    required this.positionsHeld,
    required this.vesselTypeExperience,
    required this.employmentHistory,
    required this.references,
  });
}

class EmploymentHistory {
  String companyName;
  String position;
  String startDate;
  String endDate;
  String responsibilities;

  EmploymentHistory({
    required this.companyName,
    required this.position,
    required this.startDate,
    required this.endDate,
    required this.responsibilities,
  });
}

class Reference {
  String issuedBy;
  String issuingDate;
  String vesselOrCompanyName;
  String documentUrl;

  Reference({
    required this.issuedBy,
    required this.issuingDate,
    required this.vesselOrCompanyName,
    required this.documentUrl,
  });
}




// 03 Travel Document
class TravelDocumentsCredentials {
  String seafarerRegistrationNo; // Seafarer’s Registration No.
  Passport passport; // Passport details
  SeamanBook seamanBook; // Seaman’s Book details
  SeafarerVisa validSeafarerVisa; // Valid Seafarer’s Visa details
  Visa visa; // Visa details
  ResidencePermit residencePermit; // Residence Permit details

  TravelDocumentsCredentials({
    required this.seafarerRegistrationNo,
    required this.passport,
    required this.seamanBook,
    required this.validSeafarerVisa,
    required this.visa,
    required this.residencePermit,
  });
}

class Passport {
  String passportNo; // Passport Number
  String country; // Country
  String issueDate; // Issue Date
  String expDate; // Expiry Date
  String documentUrl; // Document URL (file or image)

  Passport({
    required this.passportNo,
    required this.country,
    required this.issueDate,
    required this.expDate,
    required this.documentUrl,
  });
}

class SeamanBook {
  String seamanBookNo; // Seaman’s Book Number
  String issuingCountry; // Issuing Country
  String issuingAuthority; // Issuing Authority
  String issueDate; // Issue Date
  String expDate; // Expiry Date
  bool neverExpire; // If the Seaman's Book never expires
  String nationality; // Nationality (as recorded in Seaman's Book)
  String documentUrl; // Document URL (file or image)

  SeamanBook({
    required this.seamanBookNo,
    required this.issuingCountry,
    required this.issuingAuthority,
    required this.issueDate,
    required this.expDate,
    required this.neverExpire,
    required this.nationality,
    required this.documentUrl,
  });
}

class SeafarerVisa {
  bool valid; // Yes/No
  String issuingCountry; // Issuing Country
  String visaNo; // Visa Number
  String issuingDate; // Issue Date
  String expDate; // Expiry Date
  String documentUrl; // Document URL (file or image)

  SeafarerVisa({
    required this.valid,
    required this.issuingCountry,
    required this.visaNo,
    required this.issuingDate,
    required this.expDate,
    required this.documentUrl,
  });
}

class Visa {
  String issuingCountry; // Issuing Country
  String visaNo; // Visa Number
  String issuingDate; // Issue Date
  String expDate; // Expiry Date
  String documentUrl; // Document URL (file or image)

  Visa({
    required this.issuingCountry,
    required this.visaNo,
    required this.issuingDate,
    required this.expDate,
    required this.documentUrl,
  });
}

class ResidencePermit {
  String issuingCountry; // Issuing Country
  String permitNo; // Permit Number
  String issuingDate; // Issue Date
  String expDate; // Expiry Date
  String documentUrl; // Document URL (file or image)

  ResidencePermit({
    required this.issuingCountry,
    required this.permitNo,
    required this.issuingDate,
    required this.expDate,
    required this.documentUrl,
  });
}


// 04 Medical Document
class MedicalDocuments {
  List<MedicalFitness> medicalFitness; // List of Medical Fitness records (Repeater)
  List<DrugAlcoholTest> drugAlcoholTest; // List of Drug & Alcohol Test records (Repeater)
  List<VaccinationCertificate> vaccinationCertificates; // List of Vaccination Certificates (Repeater)

  MedicalDocuments({
    required this.medicalFitness,
    required this.drugAlcoholTest,
    required this.vaccinationCertificates,
  });
}

class MedicalFitness {
  String documentType; // e.g., PEME, HMO, Standard Medical Exam
  String certificateNo; // Alphanumerical certificate number
  String issuingCountry; // Country issuing the certificate
  String issuingClinic; // Clinic/Hospital/Authority issuing the certificate
  String issuingDate; // Issuing Date
  String expDate; // Expiry Date
  bool neverExpire; // Checkbox for some certificates that never expire
  String documentUrl; // URL for the attached document

  MedicalFitness({
    required this.documentType,
    required this.certificateNo,
    required this.issuingCountry,
    required this.issuingClinic,
    required this.issuingDate,
    required this.expDate,
    required this.neverExpire,
    required this.documentUrl,
  });

  factory MedicalFitness.fromMap(Map<String, dynamic> map) {
    return MedicalFitness(
      documentType: map['documentType'] ?? '',
      certificateNo: map['certificateNo'] ?? '',
      issuingCountry: map['issuingCountry'] ?? '',
      issuingClinic: map['issuingClinic'] ?? '',
      issuingDate: map['issuingDate'] ?? '2000-01-01',
      expDate: map['expDate'] ?? '2000-01-01',
      neverExpire: map['neverExpire'] == "true", // Parse the checkbox value
      documentUrl: map['documentUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'documentType': documentType,
      'certificateNo': certificateNo,
      'issuingCountry': issuingCountry,
      'issuingClinic': issuingClinic,
      'issuingDate': issuingDate,
      'expDate': expDate,
      'neverExpire': neverExpire.toString(),
      'documentUrl': documentUrl,
    };
  }
}

class DrugAlcoholTest {
  String documentType; // Document type (e.g., PEME)
  String certificateNo; // Alphanumerical certificate number
  String issuingCountry; // Country issuing the certificate
  String issuingClinic; // Clinic/Hospital/Authority issuing the certificate
  String issuingDate; // Issuing Date
  String expDate; // Expiry Date
  String documentUrl; // URL for the attached document

  DrugAlcoholTest({
    required this.documentType,
    required this.certificateNo,
    required this.issuingCountry,
    required this.issuingClinic,
    required this.issuingDate,
    required this.expDate,
    required this.documentUrl,
  });

  factory DrugAlcoholTest.fromMap(Map<String, dynamic> map) {
    return DrugAlcoholTest(
      documentType: map['documentType'] ?? '',
      certificateNo: map['certificateNo'] ?? '',
      issuingCountry: map['issuingCountry'] ?? '',
      issuingClinic: map['issuingClinic'] ?? '',
      issuingDate: map['issuingDate'] ?? '2000-01-01',
      expDate: map['expDate'] ?? '2000-01-01',
      documentUrl: map['documentUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'documentType': documentType,
      'certificateNo': certificateNo,
      'issuingCountry': issuingCountry,
      'issuingClinic': issuingClinic,
      'issuingDate': issuingDate,
      'expDate': expDate,
      'documentUrl': documentUrl,
    };
  }
}

class VaccinationCertificate {
  String documentType; // e.g., COVID-19, Yellow Fever, Hepatitis B, etc.
  String vaccinationCountry; // Country issuing the certificate
  String issuingClinic; // Clinic/Hospital/Authority issuing the certificate
  String issuingDate; // Issuing Date
  String expDate; // Expiry Date
  bool neverExpire; // Checkbox for certificates that never expire
  String documentUrl; // URL for the attached document

  VaccinationCertificate({
    required this.documentType,
    required this.vaccinationCountry,
    required this.issuingClinic,
    required this.issuingDate,
    required this.expDate,
    required this.neverExpire,
    required this.documentUrl,
  });

  factory VaccinationCertificate.fromMap(Map<String, dynamic> map) {
    return VaccinationCertificate(
      documentType: map['documentType'] ?? '',
      vaccinationCountry: map['vaccinationCountry'] ?? '',
      issuingClinic: map['issuingClinic'] ?? '',
      issuingDate: map['issuingDate'] ?? '2000-01-01',
      expDate: map['expDate'] ?? '2000-01-01',
      neverExpire: map['neverExpire'] == "true", // Parse the checkbox value
      documentUrl: map['documentUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'documentType': documentType,
      'vaccinationCountry': vaccinationCountry,
      'issuingClinic': issuingClinic,
      'issuingDate': issuingDate,
      'expDate': expDate,
      'neverExpire': neverExpire.toString(),
      'documentUrl': documentUrl,
    };
  }
}


// Education
class Education {
  List<AcademicQualification> academicQualifications; // Academic qualifications (Repeater)
  List<CertificationTraining> certificationsAndTrainings; // Certifications and Trainings (Repeater)
  List<Language> languagesSpoken; // Languages spoken (multiselect)

  Education({
    required this.academicQualifications,
    required this.certificationsAndTrainings,
    required this.languagesSpoken,
  });
}

class AcademicQualification {
  String educationalDegree;
  String fieldOfStudy;
  String educationalInstitution;
  String country;
  String graduationDate;
  String documentUrl;

  AcademicQualification({
    required this.educationalDegree,
    required this.fieldOfStudy,
    required this.educationalInstitution,
    required this.country,
    required this.graduationDate,
    required this.documentUrl,
  });

  factory AcademicQualification.fromMap(Map<String, dynamic> map) {
    return AcademicQualification(
      educationalDegree: map['educationalDegree'] ?? '',
      fieldOfStudy: map['fieldOfStudy'] ?? '',
      educationalInstitution: map['educationalInstitution'] ?? '',
      country: map['country'] ?? '',
      graduationDate: map['graduationDate'] ?? '2000-01-01',
      documentUrl: map['documentUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'educationalDegree': educationalDegree,
      'fieldOfStudy': fieldOfStudy,
      'educationalInstitution': educationalInstitution,
      'country': country,
      'graduationDate': graduationDate,
      'documentUrl': documentUrl,
    };
  }
}

class CertificationTraining {
  String certificationType;
  String issuingAuthority;
  String issueDate;
  String expiryDate;
  String documentUrl;

  CertificationTraining({
    required this.certificationType,
    required this.issuingAuthority,
    required this.issueDate,
    required this.expiryDate,
    required this.documentUrl,
  });

  factory CertificationTraining.fromMap(Map<String, dynamic> map) {
    return CertificationTraining(
      certificationType: map['certificationType'] ?? '',
      issuingAuthority: map['issuingAuthority'] ?? '',
      issueDate: map['issueDate'] ?? '2000-01-01',
      expiryDate: map['expiryDate'] ?? '2000-01-01',
      documentUrl: map['documentUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'certificationType': certificationType,
      'issuingAuthority': issuingAuthority,
      'issueDate': issueDate,
      'expiryDate': expiryDate,
      'documentUrl': documentUrl,
    };
  }
}

class Language {
  String language;
  String level; // (Fair, Good, Very Good, Excellent)

  Language({
    required this.language,
    required this.level,
  });

  factory Language.fromMap(Map<String, dynamic> map) {
    return Language(
      language: map['language'] ?? '',
      level: map['level'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'language': language,
      'level': level,
    };
  }
}


// ProfessionalSkills
class ProfessionalSkills {
  List<ComputerSoftware> computerAndSoftwareSkills; // Computer/Software skills (Repeater)
  CargoExperience cargoExperience; // Cargo experience (Yes/No)
  List<CargoGearExperience> cargoGearExperience; // Cargo Gear experience (Repeater)
  List<MetalWorkingSkill> metalWorkingSkills; // Metal working skills (Repeater)
  List<TankCoatingExperience> tankCoatingExperience; // Tank coating experience (Repeater)
  List<PortStateControlExperience> portStateControlExperience; // Port state control experience (Repeater)
  List<VettingInspectionExperience> vettingInspectionExperience; // Vetting inspection experience
  List<TradingAreaExperience> tradingAreaExperience; // Trading area experience (multiselect)

  ProfessionalSkills({
    required this.computerAndSoftwareSkills,
    required this.cargoExperience,
    required this.cargoGearExperience,
    required this.metalWorkingSkills,
    required this.tankCoatingExperience,
    required this.portStateControlExperience,
    required this.vettingInspectionExperience,
    required this.tradingAreaExperience,
  });
}

class ComputerSoftware {
  String software; // e.g., Danaos, Benefit, BASS net
  String level; // (Fair, Good, Very Good, Excellent)

  ComputerSoftware({
    required this.software,
    required this.level,
  });

  factory ComputerSoftware.fromMap(Map<String, dynamic> map) {
    return ComputerSoftware(
      software: map['software'] ?? '',
      level: map['level'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'software': software,
      'level': level,
    };
  }
}

class CargoExperience {
  bool bulkCargo; // e.g., Grain, Sugar, Coal
  bool tankerCargo; // e.g., LNG, LPG, Gasoline
  bool generalCargo; // e.g., Steel, Granite blocks
  bool woodProducts; // e.g., Timber, Paper rolls
  bool stowageAndLashingExperience; // General, Steel

  CargoExperience({
    required this.bulkCargo,
    required this.tankerCargo,
    required this.generalCargo,
    required this.woodProducts,
    required this.stowageAndLashingExperience,
  });

  factory CargoExperience.fromMap(Map<String, dynamic> map) {
    return CargoExperience(
      bulkCargo: map['bulkCargo'] ?? false,
      tankerCargo: map['tankerCargo'] ?? false,
      generalCargo: map['generalCargo'] ?? false,
      woodProducts: map['woodProducts'] ?? false,
      stowageAndLashingExperience: map['stowageAndLashingExperience'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bulkCargo': bulkCargo,
      'tankerCargo': tankerCargo,
      'generalCargo': generalCargo,
      'woodProducts': woodProducts,
      'stowageAndLashingExperience': stowageAndLashingExperience,
    };
  }
}

class CargoGearExperience {
  String type; // e.g., Cranes, Grabs
  String maker; // Text
  String swl; // Safe Working Load

  CargoGearExperience({
    required this.type,
    required this.maker,
    required this.swl,
  });

  factory CargoGearExperience.fromMap(Map<String, dynamic> map) {
    return CargoGearExperience(
      type: map['type'] ?? '',
      maker: map['maker'] ?? '',
      swl: map['swl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'maker': maker,
      'swl': swl,
    };
  }
}

class MetalWorkingSkill {
  String skillSelection; // e.g., Arc welding, Gas welding
  String level; // (Beginner, Intermediate, Expert)
  bool certificate; // (Yes/No)
  String documentUrl; // URL for the certificate document

  MetalWorkingSkill({
    required this.skillSelection,
    required this.level,
    required this.certificate,
    required this.documentUrl,
  });

  factory MetalWorkingSkill.fromMap(Map<String, dynamic> map) {
    return MetalWorkingSkill(
      skillSelection: map['skillSelection'] ?? '',
      level: map['level'] ?? '',
      certificate: map['certificate'] == "true",
      documentUrl: map['documentUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'skillSelection': skillSelection,
      'level': level,
      'certificate': certificate.toString(),
      'documentUrl': documentUrl,
    };
  }
}

class TankCoatingExperience {
  String type; // e.g., Epoxy, Steel, Stainless steel

  TankCoatingExperience({
    required this.type,
  });

  factory TankCoatingExperience.fromMap(Map<String, dynamic> map) {
    return TankCoatingExperience(
      type: map['type'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
    };
  }
}

class PortStateControlExperience {
  String regionalAgreement; // e.g., USCG, AMSA
  String port; // Port name
  String date; // Date
  String observations; // Any observations

  PortStateControlExperience({
    required this.regionalAgreement,
    required this.port,
    required this.date,
    required this.observations,
  });

  factory PortStateControlExperience.fromMap(Map<String, dynamic> map) {
    return PortStateControlExperience(
      regionalAgreement: map['regionalAgreement'] ?? '',
      port: map['port'] ?? '',
      date: map['date'] ?? '2000-01-01',
      observations: map['observations'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'regionalAgreement': regionalAgreement,
      'port': port,
      'date': date,
      'observations': observations,
    };
  }
}

class VettingInspectionExperience {
  String inspectionBy; // e.g., By whom
  String port; // Port name
  String date; // Date
  String observations; // Observations

  VettingInspectionExperience({
    required this.inspectionBy,
    required this.port,
    required this.date,
    required this.observations,
  });

  factory VettingInspectionExperience.fromMap(Map<String, dynamic> map) {
    return VettingInspectionExperience(
      inspectionBy: map['inspectionBy'] ?? '',
      port: map['port'] ?? '',
      date: map['date'] ?? '2000-01-01',
      observations: map['observations'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'inspectionBy': inspectionBy,
      'port': port,
      'date': date,
      'observations': observations,
    };
  }
}

class TradingAreaExperience {
  String tradingArea; // Trading area

  TradingAreaExperience({
    required this.tradingArea,
  });

  factory TradingAreaExperience.fromMap(Map<String, dynamic> map) {
    return TradingAreaExperience(
      tradingArea: map['tradingArea'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tradingArea': tradingArea,
    };
  }
}


// JobConditionsAndPreferences
class JobConditionsAndPreferences {
  String currentRankPosition; // Current Rank / Position
  String alternateRankPosition; // Alternate Rank / Position
  List<String> preferredVesselType; // Preferred Vessel Type (multiselect)
  String preferredContractType; // Preferred Contract Type (e.g., Voyage, Permanent)
  String preferredPosition; // Preferred Position (Rank)
  String manningAgency; // Manning Agency
  Availability availability; // Availability details
  Salary salary; // Salary details

  JobConditionsAndPreferences({
    required this.currentRankPosition,
    required this.alternateRankPosition,
    required this.preferredVesselType,
    required this.preferredContractType,
    required this.preferredPosition,
    required this.manningAgency,
    required this.availability,
    required this.salary,
  });
}

class Availability {
  String currentAvailabilityStatus; // Current Availability Status (e.g., Available, Onboard, On Leave)
  String availableFrom; // Available From (Date)
  int minOnBoardDuration; // Minimum Onboard Duration (in months)
  int maxOnBoardDuration; // Maximum Onboard Duration (in months)
  int minAtHomeDuration; // Minimum At Home Duration (in months)
  int maxAtHomeDuration; // Maximum At Home Duration (in months)
  String preferredRotationPattern; // Preferred Rotation Pattern
  List<String> tradingAreaExclusions; // Trading Area Exclusions

  Availability({
    required this.currentAvailabilityStatus,
    required this.availableFrom,
    required this.minOnBoardDuration,
    required this.maxOnBoardDuration,
    required this.minAtHomeDuration,
    required this.maxAtHomeDuration,
    required this.preferredRotationPattern,
    required this.tradingAreaExclusions,
  });
}

class Salary {
  double lastJobSalary; // Last Job Salary (in currency)
  String lastRankJoined; // Last Rank Joined
  String lastPromotedDate; // Last Promoted Date
  String currency; // Currency (e.g., USD, EUR)
  String justificationDocumentUrl; // Justification Document URL
  bool industryStandardSalaryCalculator; // Industry Standard Salary Calculator availability

  Salary({
    required this.lastJobSalary,
    required this.lastRankJoined,
    required this.lastPromotedDate,
    required this.currency,
    required this.justificationDocumentUrl,
    required this.industryStandardSalaryCalculator,
  });
}

class SecurityAndComplianceInfo {
  bool contactInfoSharing;
  bool dataSharing;
  bool professionalConductDeclaration;

  SecurityAndComplianceInfo({
    required this.contactInfoSharing,
    required this.dataSharing,
    required this.professionalConductDeclaration,
  });
}

