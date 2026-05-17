import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

import 'package:sham_booking/injection_container.dart' as di;

class Bootstrap {
  static Future<void> init() async {
    await ScreenUtil.ensureScreenSize();
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    await GetStorage.init();
    await di.init();
  }
}
