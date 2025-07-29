
// Whole App's API URL
const baseUrl = 'https://luneta.microlent.com/api/'; // Base URL

// const mapKey = 'AIzaSyB2JtqK5DXLKUGE1GCjH0TzX2xbHJPzFug'; // Base URL
const mapKey = 'AIzaSyCuacSCdbor7YMMMO2lR4x3otzJkRcW2rE'; // Base URL


const loginUrl = '${baseUrl}user/login';
const signupUrl = '${baseUrl}user/register';
const forgotUrl = '${baseUrl}Login/forget-password';
const otpVerifyUrl = '${baseUrl}Login/verify-code';
const resetUrl = '${baseUrl}Login/reset-password';
const updatePasswordUrl = '${baseUrl}User/UpdatePassword/update-password';
const getCategoriesUrl = '${baseUrl}User/GetUserById/';
const refreshTokenUrl = '${baseUrl}auth/refresh-token';
const updateProfile= '${baseUrl}/User/UpdateUser/';

// HOME
const getAmenitiesUrl = '${baseUrl}Amenity/GetAllAmenityTypes';
const getPricingUrl = '${baseUrl}Location/GetPriceRangeDropdown';
const getWineListingsUrl = '${baseUrl}Location/GetLocationsWithNearby/paginated-nearby';
const postViewAllUrl = '${baseUrl}Location/GetUserLocations?';
const getAboutDetailsUrl = '${baseUrl}Location/GetLocationByIdForEndUser/GetLocationById/';
const getExperienceByIdUrl = '${baseUrl}Experience/GetExperienceById/';
const getAmenetiesByIdUrl = '${baseUrl}Amenity/GetAmenityTypesByLocation/by-location/';
const getExpTitleIdUrl = '${baseUrl}Experience/GetExperiencesListByLocationId/';
const getTimeSlotUrl = '${baseUrl}TimeSlot/GetTimeSlotsByDate/by-date?';
const getMapLocationUrl = '${baseUrl}Location/GetUserLocationsForMAp';
const postCheckAvailability = '${baseUrl}Booking/CheckAvailability';
const postCreateBooking = '${baseUrl}Booking/CreateBooking';



