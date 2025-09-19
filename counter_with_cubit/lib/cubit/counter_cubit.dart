import 'package:counter_with_cubit/cubit/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitial());

  int counter = 0;

  add() async {
    emit(CounterLoadingState());
    await Future.delayed(Duration(seconds: 1), () {
      counter++;
      emit(CounterAddedState());
    });
  }

  remove() {
    counter--;
    emit(CounterSubtractedState());
  }
}
