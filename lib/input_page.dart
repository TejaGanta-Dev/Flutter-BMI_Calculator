import 'package:flutter/material.dart';

import 'package:bmi_caluculator/result.dart';
import 'package:bmi_caluculator/results.dart';
import 'package:bmi_caluculator/sliderChanges.dart';
import 'package:bmi_caluculator/colors/app_colors.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  containerCard(final Color colour, final Widget childWidget) {
    return Expanded(
      child: Container(
        height: 185.0,
        margin: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: childWidget,
      ),
    );
  }

  int currentSliderValue = 150;
  int currentWeightValue = 70;
  int currentAge = 23;

  getBMI() {
    final double height = currentSliderValue / 100;
    final double bmi = currentWeightValue / (height * height);
    return bmi.toInt();
  }

  getBMIContext() {
    final bmi = getBMI();
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Normal weight';
    } else if (bmi >= 24.9 && bmi < 29.9) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }

  String getLikeMessageForBMI() {
    final String message = getBMIContext();
    switch (message) {
      case 'Underweight':
        return 'You have a lower than normal body weight. Good job!';
      case 'Normal weight':
        return 'You have a normal body weight. Good job!';
      case 'Overweight':
        return 'You have a higher than normal body weight. Try to exercise more!';
      case 'Obese':
        return 'You have an obese body weight. Please consult a doctor!';
      default:
        return 'Invalid BMI message';
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color colourForContainer = Color(0xFF1D1E33);

    updateTap(String gender) {
      setState(() {
        if (gender == 'Male') {
          femaleCardColor = inActiveCardColor;
          maleCardColor = activeCardColor;
        } else {
          maleCardColor = inActiveCardColor;
          femaleCardColor = activeCardColor;
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
          title: const Center(
              child: Text(
        'BMI Caluculator',
        style: TextStyle(color: Colors.white),
      ))),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                containerCard(
                  maleCardColor,
                  GestureDetector(
                    onTap: () {
                      updateTap('Male');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        iconReUsable(FontAwesomeIcons.mars, 80.0),
                        sizedBoxReusable(15.0),
                        textBoxReUsable('Male', 18.0, const Color(0xFF8D8E98))
                      ],
                    ),
                  ),
                ),
                containerCard(
                  femaleCardColor,
                  GestureDetector(
                    onTap: () {
                      updateTap('Female');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        iconReUsable(FontAwesomeIcons.venus, 80.0),
                        sizedBoxReusable(15.0),
                        textBoxReUsable('Female', 18.0, const Color(0xFF8D8E98))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            containerCard(colourForContainer, MiddleTile(
              sliderValue: (int value) {
                setState(() {
                  currentSliderValue = value;
                });
              },
            )),
            Row(
              children: <Widget>[
                containerCard(
                  colourForContainer,
                  WeightWidget(
                    weight: (weight) {
                      print(weight);
                      setState(() {
                        currentWeightValue = weight;
                      });
                    },
                  ),
                ),
                containerCard(
                  colourForContainer,
                  Column(
                    children: [
                      WeightWidget(
                        title: 'Age',
                        deafultVal: 23,
                        weight: (age) {
                          print('Age:$age');
                          setState(() {
                            currentAge = age;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
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
                  'Calculate',
                  style: TextStyle(fontSize: 24.0, color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Result(
                        resultText: getBMIContext(),
                        resultLongText: getLikeMessageForBMI(),
                        BMIResult: getBMI(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sizedBoxReusable(double heightOfTheBox) {
    return SizedBox(height: heightOfTheBox);
  }

  Widget textBoxReUsable(String text, double fontSize, Color fontColor) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: fontColor,
      ),
    );
  }

  Widget iconReUsable(IconData icon, double size) {
    return Icon(
      icon,
      size: size,
      color: Colors.white,
    );
  }
}

class MiddleTile extends StatefulWidget {
  final void Function(int) sliderValue;

  const MiddleTile({super.key, required this.sliderValue});
  @override
  State<MiddleTile> createState() {
    return _MiddleTileState();
  }
}

class _MiddleTileState extends State<MiddleTile> {
  double val = 150;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: Center(
              child: Text(
            'HEIGHT',
            style: TextStyle(color: const Color(0xFF8D8E98), fontSize: 20.0),
          )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                  child: Text(
                val.toStringAsFixed(2),
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 50.0),
              )),
            ),
            const Center(
                child: Text(
              'cm',
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            )),
          ],
        ),
        SliderTheme(
          data: const SliderThemeData(
            activeTrackColor: Colors.white,
            thumbColor: Colors.red,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
          ),
          child: Slider(
            onChanged: (double value) {
              setState(() {
                val = value;
              });
              widget.sliderValue(value.toInt());
            },
            value: val,
            min: 100.0,
            max: 220.0,
            activeColor: const Color.fromARGB(255, 183, 179, 179),
            inactiveColor: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class WeightWidget extends StatefulWidget {
  final void Function(int) weight;
  final String title;
  final int deafultVal;

  const WeightWidget({
    super.key,
    required this.weight,
    this.title = 'Weight',
    this.deafultVal = 70,
  });

  @override
  State<WeightWidget> createState() => _WeightWidgetState();
}

class _WeightWidgetState extends State<WeightWidget> {
  int weight = 0;

  @override
  void initState() {
    super.initState();

    weight = widget.deafultVal;
  }

  updateWeight({String type = 'Increment'}) {
    if (type == 'Increment') {
      setState(() {
        weight += 1;
        widget.weight(weight);
      });
    } else {
      weight -= 1;
      widget.weight(weight);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 20.0),
          child: textBoxReUsable(widget.title, 18.0, const Color(0xFF8D8E98)),
        ),
        Container(
          child: textBoxReUsable(weight.toString(), 50.0, Colors.white),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FloatingActionButton.small(
              heroTag: '${widget.title}-ss',
              backgroundColor: const Color(0xFF4C4F5E),
              onPressed: () {
                updateWeight();
              },
              shape: const CircleBorder(),
              child: const SizedBox(
                width: 40.0,
                height: 40.0,
                child: Icon(
                  Icons.add,
                  size: 35.0,
                  color: Colors.white,
                ),
              ),
            ),
            FloatingActionButton.small(
              heroTag: '${widget.title}-s22',
              backgroundColor: const Color(0xFF4C4F5E),
              onPressed: () {
                updateWeight(type: '');
              },
              shape: const CircleBorder(),
              child: const Icon(
                Icons.remove,
                size: 35.0,
                color: Colors.white,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget textBoxReUsable(String text, double fontSize, Color fontColor) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: fontColor,
      ),
    );
  }
}
