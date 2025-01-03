import 'package:flutter_bloc/flutter_bloc.dart';

class PercentageCubit extends Cubit<int> {
  PercentageCubit() : super(0);

  void updateProcessedCells(int newlyProcessedCells) {
    emit(state + newlyProcessedCells);
  }

  void resetProcessedCells() {
    emit(0);
  }
}
