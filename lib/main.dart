import 'package:flutter/material.dart';
import 'package:signal/model/signal_generator.dart';

import 'monitor_page.dart';

void main() {
  runApp(MaterialApp(title: 'Test',
      // home: MyApp()
      home: Monitor(),
      ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Signal_Generator _signal_generator;

  String val = '';

  void Signal_recieved(double v) {
    setState(() {
      val = v.toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _signal_generator = Signal_Generator(
        time_inhale: 3 * 1000,
        time_exhale: 3 * 1000,
        time_rest: 1 * 1000,
        max_inhale: 150,
        max_exhale: 150,
        onSignalGenerated: Signal_recieved);
    _signal_generator.run();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
        actions: [
          IconButton(
              onPressed: () {
                _signal_generator.pause();
              },
              icon: Icon(Icons.pause)),
          IconButton(onPressed: (){
            _signal_generator.resume();
          }, icon: Icon(Icons.play_arrow))
        ],
      ),
      body: Center(
        child: Text(
          'Stream Value: $val',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _signal_generator.dispose();
  }
}
