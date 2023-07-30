import 'package:flutter/material.dart';
import 'package:signal/model/signal_generator.dart';
import 'package:signal/model/signal_matching.dart';

import 'model/oscilloscope.dart';

class Monitor extends StatefulWidget {
  const Monitor({super.key});

  @override
  State<Monitor> createState() => _MonitorState();
}

class _MonitorState extends State<Monitor> {
  late Oscilloscope scopeOne;
  late Signal_Generator _signal_generator1;
  late Signal_Generator _signal_generator2;

  late Signal_Matching matcher;

  List<double> SignalDataSet1 = [];
  List<double> SignalDataSet2 = [];

  void signal1_recieves(double s) {
    setState(() {
      SignalDataSet1.add(s);
    });
  }

  void signal2_recieves(double s) {
    setState(() {
      SignalDataSet2.add(s);
    });
  }

  @override
  initState() {
    super.initState();
    _signal_generator1 = Signal_Generator(
        time_inhale: 3 * 1000,
        time_exhale: 3 * 1000,
        time_rest: 1 * 1000,
        max_inhale: 150,
        max_exhale: 150,
        onSignalGenerated: signal1_recieves);
    _signal_generator2 = Signal_Generator(
        time_inhale: 5 * 1000,
        time_exhale: 5 * 1000,
        time_rest: 3 * 1000,
        max_inhale: 100,
        max_exhale: 100,
        onSignalGenerated: signal2_recieves);

    matcher = Signal_Matching(signal1: SignalDataSet1, signal2: SignalDataSet2);
    _signal_generator1.run();
    _signal_generator2.run();
  }

  @override
  Widget build(BuildContext context) {
// Create A Scope Display for Sine
    scopeOne = Oscilloscope(
      showYAxis: true,
      yAxisColor: Colors.orange,
      margin: EdgeInsets.all(20.0),
      strokeWidth: 3.0,
      backgroundColor: Colors.black,
      traceColor1: Colors.green,
      traceColor2: Colors.yellow,
      yAxisMax: 150,
      yAxisMin: -150,
      dataSet1: SignalDataSet1,
      dataSet2: SignalDataSet2,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
        actions: [
          IconButton(
              onPressed: () {
                print(matcher.absolute_error(-1));
              },
              icon: Icon(Icons.question_mark))
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: scopeOne,
          ),
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.black,
                height: MediaQuery.of(context).size.height / 2,
              ))
        ],
      ),
    );
  }
}
