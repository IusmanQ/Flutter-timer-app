import 'package:equatable/equatable.dart';

abstract class TimerEvent extends Equatable {
  TimerEvent();
  @override
  List<Object> get props => [];
}

class TimerStarted extends TimerEvent{
  TimerStarted(this.duration);
  final int duration;
}

class TimerPaused extends TimerEvent{
  TimerPaused();
}

class TimerResumed extends TimerEvent{
  TimerResumed();
}

class TimerReset extends TimerEvent{
  TimerReset();
}

class TimerTicked extends TimerEvent{
  TimerTicked(this.duration);
  final int duration;

  @override
  // TODO: implement props
  List<Object> get props => super.props;
}