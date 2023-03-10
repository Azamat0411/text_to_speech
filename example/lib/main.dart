import 'package:flutter/material.dart';
import 'package:text_to_speech/text_to_speech_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final tts = TextToSpeechPlugin();
  final _textController = TextEditingController();
  double pitch = 1.0;
  double rate = 1.0;
  String value = "Male";

  void _speak() {
    tts.setVoice(value == 'Male' ? true : false);
    tts.setPitch(pitch);
    tts.setRate(rate);
    tts.speak(_textController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(controller: _textController, decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),),
            ),
            Text(
              'Pitch $pitch',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Slider(
                value: pitch,
                onChanged: (v) {
                  setState(() {
                    pitch = v;
                  });
                }),
            Text(
              'Rate $rate',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Slider(
                value: rate,
                max: 2.0,
                onChanged: (v) {
                  setState(() {
                    rate = v;
                  });
                }),
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                items: ["Male", "Famale"]
                    .map((e) => DropdownMenuItem<String>(
                        value: e,
                        child: Text(
                          e,
                          style: const TextStyle(color: Colors.black),
                        )))
                    .toList(),
                onChanged: (v) {
                  setState(() {
                    value = v!;
                  });
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _speak,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
