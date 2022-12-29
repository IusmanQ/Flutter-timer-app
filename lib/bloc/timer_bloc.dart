import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_app/events/timer_events.dart';
import 'package:timer_app/model/ticker.dart';
import 'package:timer_app/state/timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState>{
  final Ticker _ticker;
  static const int _duration = 60;

  StreamSubscription<int> _tickerSubscription;
  TimerBloc(Ticker ticker) : _ticker = ticker, super(TimerInitial(_duration));

  @override
  Stream<TimerState> mapEventToState(TimerEvent event) async* {
    if(event is TimerStarted){
      yield* _mapTimerStartedtoState(event);
    } else if (event is TimerTicked){
      yield* _mapTimerTickertoState(event);
    } else if(event is TimerPaused) {
      yield* _mapTimerPausedtoState(event);
    } else if(state is TimerResumed) {
      yield* _mapTimerResumedtoState(event);
    } else if(state is TimerReset) {
      yield* _maptTimerResettoState(event);
    }
    throw UnimplementedError();
  }

  Stream<TimerState> _mapTimerStartedtoState(TimerStarted start) async* {
    yield TimerRunInProgress(start.duration);
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick(start.duration).listen((duration) => add(TimerTicked(duration)));
  }

  Stream<TimerState> _mapTimerTickertoState(TimerTicked tick) async* {
    yield tick.duration > 0 ? TimerRunInProgress(tick.duration) : TimerRunComplete(tick.duration);
  }

  Stream<TimerState> _mapTimerPausedtoState(TimerPaused pause) async* {
    if(state is TimerRunInProgress){
      _tickerSubscription?.cancel();
      yield TimerRunPause(state.duration);
    }
  }

  Stream<TimerState> _mapTimerResumedtoState(TimerResumed resume) async* {
    if(state is TimerRunPause) {
      _tickerSubscription?.cancel();
      yield TimerRunInProgress(state.duration);
    }
  }

  Stream<TimerState> _maptTimerResettoState(TimerReset reset) async* {
    _tickerSubscription?.cancel();
    yield TimerInitial(_duration);
  }


  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}