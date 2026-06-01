import 'package:bloc/bloc.dart';
import 'package:sham_booking/core/constants/app_string.dart';
import 'package:sham_booking/core/helpers/storage_helper.dart';

class OnBoardingCubit extends Cubit<int> {
  OnBoardingCubit() : super(0);

  void changePage(int index) {
    emit(index);
  }

  Future<void> finishPage() async {
    await box.write(isFirstOpenKey, true);
  }
}
