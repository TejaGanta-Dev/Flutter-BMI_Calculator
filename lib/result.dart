import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names

class Result extends StatelessWidget {
  final int bmiCal;
  final String resultText;
  final String resultLongText;

  const Result(
      {super.key,
      required this.bmiCal,
      required this.resultLongText,
      required this.resultText});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0A0E21),
        ),
      ),
      home: Scaffold(
          appBar: AppBar(
              title: ListTile(
            leading: GestureDetector(
              child: const Icon(Icons.car_crash),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            title: const Center(
              child: Text(
                'BMI Calculator',
                style: TextStyle(color: Colors.white, fontSize: 26.0),
              ),
            ),
          )),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  color: const Color(0xFF111323),
                  child: Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Your Result',
                          style: TextStyle(color: Colors.white, fontSize: 50.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          resultText.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.green, fontSize: 25.0),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          bmiCal.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 80.0,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            resultLongText,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 80.0,
                width: double.infinity,
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFEB1555),
                  borderRadius: BorderRadius.circular(0.0),
                ),
                child: TextButton(
                  child: const Text(
                    'Re-Calculate',
                    style: TextStyle(fontSize: 24.0, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          )),
    );
  }
}
