import 'dart:math';

class Signal_Matching{

  List<double> signal1;
  List<double> signal2;
  Signal_Matching({required this.signal1, required this.signal2});

  double absolute_error(int window_size)
  {

    int l1 = signal1.length;
    int l2 = signal2.length;

    int checking_window = min(l1,l2);

    if(window_size > checking_window)
      window_size = checking_window;

    if(window_size==-1)
      window_size = checking_window;

    double error = 0 ;

    int count = 0;
    for(int i=checking_window-1 ; i >=checking_window-window_size ; i--) {
      count += 1 ;
      error += (signal2[i] - signal1[i]).abs();
    }

    return error / count;
  }

}