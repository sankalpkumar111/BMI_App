import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        primarySwatch: Colors.red,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var wtController = TextEditingController();
  var ftController = TextEditingController();
  var inController = TextEditingController();
  var result = "";
  var bgColor = Colors.blue.shade200;

  void reset() {
    setState(() {
      wtController.clear();
      ftController.clear();
      inController.clear();
      result = "";
      bgColor = Colors.blue.shade200;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("BMI Calculator"),
      ),
      body: Container(
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [
        //      Color(0xfff6d365),Color(0xfffda085)
        //     ],
        //         begin: FractionalOffset(1.0,0.0),
        //         end: FractionalOffset(0.0,1.0)
        //   )
        // ),
        // color: bgColor,
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView( // Added SingleChildScrollView
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'BMI Calculator',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 21),
                TextField(
                  controller: wtController,
                  decoration: const InputDecoration(
                    label: Text("Enter your weight in kg"),
                    prefixIcon: Icon(Icons.line_weight),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 11),
                TextField(
                  controller: ftController,
                  decoration: const InputDecoration(
                    label: Text("Enter your height in feet"),
                    prefixIcon: Icon(Icons.height),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 11),
                TextField(
                  controller: inController,
                  decoration: const InputDecoration(
                    label: Text("Enter your height in inches"),
                    prefixIcon: Icon(Icons.height),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 21),
                ElevatedButton(
                  onPressed: () {
                    var wt = wtController.text.toString();
                    var ft = ftController.text.toString();
                    var inch = inController.text.toString();

                    if (wt.isEmpty || ft.isEmpty || inch.isEmpty) {
                      setState(() {
                        result = "Please fill all the required fields";
                      });
                    } else {
                      var iWT = int.parse(wt);
                      var iFt = int.parse(ft);
                      var iInch = int.parse(inch);

                      var tInch = (iFt * 12) + iInch;
                      var tCm = tInch * 2.54;

                      var tM = tCm / 100;

                      var bmi = iWT / (tM * tM);
                      var msg = "";
                      if (bmi > 25) {
                        msg = "You are Overweight";
                        bgColor = Colors.orange.shade200;
                      } else if (bmi < 18) {
                        msg = "You are Underweight";
                        bgColor = Colors.red.shade200;
                      } else {
                        msg = "You are at a Healthy weight";
                        bgColor = Colors.green.shade200;
                      }
                      setState(() {
                        result = "$msg\nYour BMI is: ${bmi.toStringAsFixed(2)}";
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Calculate"),
                ),
                const SizedBox(height: 11),
                ElevatedButton(
                  onPressed: reset,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Reset"),
                ),
                const SizedBox(height: 21),
                Text(
                  result,
                  style: const TextStyle(fontSize: 19),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 21),
                const BMIInfoBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BMIInfoBox extends StatelessWidget {
  const BMIInfoBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            Text(
              "BMI Categories:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text("Underweight: < 18.5"),
            Text("Normal weight: 18.5–24.9"),
            Text("Overweight: 25–29.9"),
            Text("Obesity: BMI of 30 or greater"),
          ],
        ),
      ),
    );
  }
}
