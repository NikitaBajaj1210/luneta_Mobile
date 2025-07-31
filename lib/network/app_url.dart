
// Whole App's API URL
const baseUrl = 'https://luneta.microlent.com/api/'; // Base URL

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

//post
const postUpdatePersonalInfo = '${baseUrl}seafarer-profile/personal-info-create-or-update';
