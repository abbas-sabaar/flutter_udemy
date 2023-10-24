abstract class CounterStates {}

class CounterInitialStats extends CounterStates {}

class CounterMinusStats extends CounterStates {
  final int counter;

  CounterMinusStats(this.counter);
}

class CounterPlusStats extends CounterStates {
  final int counter;

  CounterPlusStats(this.counter);
}

class CounterRestoreIconStats extends CounterStates {
  final int counter;

  CounterRestoreIconStats(this.counter);
}
