import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_app/bloc/timer_bloc.dart';
import 'package:timer_app/model/ticker.dart';
import 'package:timer_app/screens/timer_view.dart';

class TimerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TimerBloc>(
      create: (context) => TimerBloc(Ticker()),
          child: TimerView(),
    );
  }
}
