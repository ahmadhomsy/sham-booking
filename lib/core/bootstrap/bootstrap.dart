import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sham_booking/core/config/stripe_config.dart';
import 'package:sham_booking/firebase_options.dart';
import 'package:sham_booking/injection_container.dart' as di;

class Bootstrap {
  static Future<void> init() async {
    await ScreenUtil.ensureScreenSize();
    Stripe.publishableKey = StripeConfig.publishableKey;
    await Stripe.instance.applySettings();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await GetStorage.init();
    await di.init();
  }
}
