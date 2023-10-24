import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udemy/modules/counter_app/counter/cubit/states.dart';

class CounterCubit extends Cubit<CounterStates> {
  CounterCubit() : super(CounterInitialStats());

  static CounterCubit get(context) => BlocProvider.of(context);

  int counter = 0;

  void mines() {
    counter--;
    emit(CounterMinusStats(counter));
  }

  void plus() {
    counter++;
    emit(CounterPlusStats(counter));
  }

  void restoreIcon() {
    counter = 0;
    emit(CounterRestoreIconStats(counter));
  }
}
