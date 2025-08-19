
// Whole App's API URL
// const baseUrl = 'http://192.168.29.56:3004/api/'; // Base URL
// const baseUrl = 'https://luneta.microlent.com/api/'; // Base URL
const baseUrl = 'https://stage-luneta.nanobyte.gr/api/'; // Base URL

const loginUrl = '${baseUrl}user/login';
const signupUrl = '${baseUrl}user/register';
const forgotUrl = '${baseUrl}Login/forget-password';
const otpVerifyUrl = '${baseUrl}Login/verify-code';
const resetUrl = '${baseUrl}user/reset-password';
const getAllRank = '${baseUrl}ranks/getAll';
const seafarerProfileBasicInfo = '${baseUrl}seafarer-profile/basic-info';
const sendOtpUrl = '${baseUrl}user/forget-password-mobile';
const verifyOtpUrl = '${baseUrl}user/verify-otp';
const getPersonalInfoProfile_Complete = '${baseUrl}seafarer-profile/getCompleteProfileDataMobile/';
const getPersonalInfoProfile = '${baseUrl}seafarer-profile/getone/personal-information/';
const verifyOtpForgotUrl = '${baseUrl}user/verify-otp-mobile';


const getSeafarerCompleteProfile = '${baseUrl}seafarer-profile/getCompleteProfileDataMobile/';
const getTravelDocumentsByUserId = '${baseUrl}seafarer-profile/travel-documents/getByUserId/';
const createOrUpdateTravelDocuments = '${baseUrl}seafarer-profile/travel-documents/create-or-update';
const getMedicalDocumentsByUserId = '${baseUrl}seafarer-profile/medical-documents/getByUserId/';
const createOrUpdateMedicalDocuments = '${baseUrl}seafarer-profile/medical-documents/create-or-update';
const getProfessionalExperienceByUserId = '${baseUrl}professional-experience/get-by-user-profile/';
const createOrUpdateProfessionalExperience = '${baseUrl}professional-experience/create-or-update';
const getEducationByUserId = '${baseUrl}seafarer-profile/education-getByUserId/';
const createOrUpdateEducation = '${baseUrl}seafarer-profile/education/create-or-update';
const getProfessionalSkillsByUserId = '${baseUrl}seafarer-profile/professional-skills/';
const createOrUpdateProfessionalSkills = '${baseUrl}seafarer-profile/professional-skills/create-or-update/';
const getJobConditionsByUserId = '${baseUrl}seafarer-profile/job-conditions/';
const postJobConditionsByUserId = '${baseUrl}seafarer-profile/job-conditions/create-or-update';
const getMasterCargoExperience = '${baseUrl}master-cargo-experience';
const postMasterCargoExperience = '${baseUrl}master-cargo-experience/bulk-cargo-create-or-update';
const getMasterTankerCargo = '${baseUrl}master-tanker-cargo/get-all';
const postMasterTankerCargo = '${baseUrl}master-tanker-cargo/bulk-tanker-cargo-create-or-update';
const getMasterGeneralCargo = '${baseUrl}master-general-cargo/get-all';
const postMasterGeneralCargo = '${baseUrl}master-general-cargo/bulk-general-cargo-create-or-update';
const getMasterWoodProduct = '${baseUrl}master-wood-products/get-all';
const postMasterWoodProduct = '${baseUrl}master-wood-products/bulk-wood-product-create-or-update';
const getMasterLashingExperience = '${baseUrl}master-lashing-experience/get-all';



//post
const postUpdatePersonalInfo = '${baseUrl}seafarer-profile/personal-info-create-or-update';
const postUpdateCompliance = '${baseUrl}seafarer-profile/security-compliance/create-or-update';

const getAllAgency = '${baseUrl}master-manning-agency/get-all';


//USED  TO API
// /api/master-general-cargo/bulk-general-cargo-create-or-update
// /api/master-general-cargo/get-all
//
// /api/master-wood-products/bulk-wood-product-create-or-update
// /api/master-wood-products/get-all
//
// /api/master-tanker-cargo/bulk-tanker-cargo-create-or-update
// /api/master-tanker-cargo/get-all
//
// /api/master-lashing-experience/bulk-lashing-create-or-update
// /api/master-lashing-experience/get-all
//
// /api/master-cargo-experience/bulk-cargo-create-or-update
// /api/master-cargo-experience