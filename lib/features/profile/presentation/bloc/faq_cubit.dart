import 'package:bloc/bloc.dart';

class FaqCubit extends Cubit<Set<int>> {
  FaqCubit() : super({});
  void toggle(int index) {
    final currentSet = Set<int>.from(state);
    if (currentSet.contains(index)) {
      currentSet.remove(index);
    } else {
      currentSet.add(index);
    }
    emit(currentSet);
  }
}
