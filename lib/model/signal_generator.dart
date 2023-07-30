import 'dart:async';

class Signal_Generator{

  int time_inhale ;
  int time_rest ;
  int time_exhale;
  int max_inhale;
  int max_exhale;

  int _timer_delay = 500;

  int step = 0 ;
  Timer? _timer;

  Function(double)? onSignalGenerated;

  Signal_Generator({required this.time_inhale,required this.time_exhale,
    required this.time_rest,required this.max_inhale,required this.max_exhale, this.onSignalGenerated}){
  }

  void run(){
    _startUpdatingStream();
  }

  void pause()
  {
    _timer!.cancel();
  }

  void resume()
  {
    _startUpdatingStream();
  }

  void restart()
  {
    _timer!.cancel();
    step = 0 ;
    _startUpdatingStream();
  }



  double _generate_ideal_signal(int step) {
    step = step % (time_inhale + time_exhale + 2 * time_rest);
    if (step < time_inhale)
      return (max_inhale / time_inhale) * step - max_inhale;
    else if (time_inhale <= step && step < time_inhale + time_rest)
      return 0;
    else if (time_inhale + time_rest <= step && step < time_inhale + time_rest + time_exhale)
      return -(max_exhale / time_exhale) * (step - time_inhale - time_rest) + max_exhale;
    else
      return 0;
  }

  void _startUpdatingStream() {
    _timer = Timer.periodic(Duration(milliseconds: _timer_delay), (timer) {
      step += 1;
      double signal = _generate_ideal_signal(step* _timer_delay);
      onSignalGenerated!(signal);
    });
  }

  void dispose() {
    _timer?.cancel();
  }



}