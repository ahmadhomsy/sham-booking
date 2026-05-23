import 'package:sham_booking/core/constants/app_string.dart';
import 'package:sham_booking/core/error/exceptions.dart';
import 'package:sham_booking/core/helpers/storage_helper.dart';

abstract class LocalAuthDataSource {
  Future<bool> loggedIn();
}

class LocalAuthDataSourceImpl implements LocalAuthDataSource {
  LocalAuthDataSourceImpl();

  @override
  Future<bool> loggedIn() async {
    if (box.read<bool>(isFirstOpenKey) != null) {
      if (box.read<bool>(isLoggedInKey) != null) {
        throw NotSignException();
      } else if (box.read<bool>(isVerifiedKey) != null) {
        return true;
      } else {
        throw NotSignException();
      }
    } else {
      throw IsFirstOpenException();
    }
  }
}
