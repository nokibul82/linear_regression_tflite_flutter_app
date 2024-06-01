import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Basic Linear Regression Tensorflow Lite',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Basic Linear Regression Tensorflow Lite'),
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
  TextEditingController controller = TextEditingController();
  var result = List.filled(1 * 1, 0).reshape([1,1]);
  late var interpreter;
  @override
  void initState() {
    super.initState();
    loadModel();
  }

  void loadModel() async {
    interpreter = await Interpreter.fromAsset('assets/linear_basic.tflite');
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Give a number to predict the output. The lienear regression was made to predict the pattern of a dataset which follows this equation 2n-1.',
            ),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                  hintText: "Enter a number", border: InputBorder.none),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    interpreter.run([
                      int.parse(controller.text)
                    ], result);
                    setState(() {

                    });
                  },
                  child: const Text("Submit")),
            ),
            Text('Output: $result'),
          ],
        ),
      ),
    );
  }
}
