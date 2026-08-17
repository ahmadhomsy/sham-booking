class EndPoints {
  static const String baseUrl = 'https://shambooking.aboodm.com/api';
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String updateProfile = '/users';
  static String updateProfileWithId(int id) => '/users/$id';
  static const String getProfile = '/auth/profile';
  static const String sendVerificationCode = '/auth/send-verification-code';
  static const String verifyCode = '/auth/verify-verification-code';
  static const String refreshToken = '/auth/refresh';
  static const String getAllHotels = '/hotels/';
  static String getHotelDetails(int id) => '$getAllHotels$id';
  static const String getRoom = '/rooms';
  static String showRoom(int id) => '$getRoom/$id';
  static const String getAvailableRooms = '/rooms-type/available';
  static const String getHotelRoom = '/rooms-type';
  static const String bookings = '/bookings';
  static const String stripeCheckout = '/payments/stripe/checkout';
}
