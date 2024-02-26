// ignore_for_file: non_constant_identifier_names

import 'dart:collection';
import 'dart:io';

import 'package:bmi_caluculator/result.dart';
import 'package:bmi_caluculator/results.dart';
import 'package:bmi_caluculator/sliderChanges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final activeCardColor = const Color(0xFF1D1E33);
  final inActiveCardColor = const Color(0xFF111323);
  Color femaleCardColor = const Color(0xFF1D1E33);
  Color maleCardColor = const Color(0xFF1D1E33);

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

  @override
  Widget build(BuildContext context) {
    const Color colourForContainer = Color(0xFF1D1E33);
    SizedBoxReusable(double heightOfTheBox) {
      return SizedBox(height: heightOfTheBox);
    }

    TextBoxReUsable(String text, double fontSize, Color fontColor) {
      return Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: fontColor,
        ),
      );
    }

    IconReUsable(IconData icon, double size) {
      return Icon(
        icon,
        size: size,
        color: Colors.white,
      );
    }

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

    SliderCurrentValue SliderValue = SliderCurrentValue();
    int height=150;
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
                        IconReUsable(
                          FontAwesomeIcons.mars,
                          80.0,
                        ),
                        SizedBoxReusable(15.0),
                        TextBoxReUsable(
                          'Male',
                          18.0,
                          const Color(0xFF8D8E98),
                        )
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
                        IconReUsable(
                          FontAwesomeIcons.venus,
                          80.0,
                        ),
                        SizedBoxReusable(15.0),
                        TextBoxReUsable(
                          'Female',
                          18.0,
                          const Color(0xFF8D8E98),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            containerCard(
              colourForContainer,
              MiddleTile(
                  currentSliderValue: SliderValue.getCurrentSliderValue()),
            ),
            Row(
              children: <Widget>[
                containerCard(
                  colourForContainer,
                  WeightWidget(),
                ),
                containerCard(
                    colourForContainer,
                    Column(
                      children: const <Widget>[AgeWidget()],
                    )),
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
                  setState(() {
                    BMICAL sliderCurrentValue = BMICAL(
                        height: SliderValue.getCurrentSliderValue(),
                        weight: SliderValue.getCurrentWeightValue());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Result(
                          resultText: sliderCurrentValue.getBMIContext(),
                          resultLongText:
                              sliderCurrentValue.getLikeMessageForBMI(),
                          BMIResult: sliderCurrentValue.getBMI(),
                        ),
                      ),
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MiddleTile extends StatefulWidget {
  const MiddleTile({super.key, required final int currentSliderValue});
  @override
  State<MiddleTile> createState() {
    return _MiddleTileState();
  }
}

class _MiddleTileState extends State<MiddleTile> {
  SliderCurrentValue SliderValue = SliderCurrentValue();
  int currentSliderValue = 150;
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
                SliderValue.getCurrentSliderValue().toString(),
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
                currentSliderValue = value.round();
                // SliderValue.updateSliderValue(currentSliderValue);
              });
            },
            value: SliderValue.getCurrentSliderValue().toDouble(),
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
  const WeightWidget({super.key});

  @override
  State<WeightWidget> createState() => _WeightWidgetState();
}

class _WeightWidgetState extends State<WeightWidget> {
  SliderCurrentValue SliderValue = SliderCurrentValue();
  @override
  Widget build(BuildContext context) {
    String currentWeightValue = SliderValue.getCurrentWeightValue().toString();
    updateWeight(String type) {
      if (type == 'Increment') {
        SliderValue.incrementWeight();
      } else {
        SliderValue.decrementWeight();
      }
      setState(() {
        currentWeightValue = SliderValue.getCurrentWeightValue().toString();
      });
    }

    TextBoxReUsable(String text, double fontSize, Color fontColor) {
      return Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: fontColor,
        ),
      );
    }

    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 20.0),
          child: TextBoxReUsable('Weight', 18.0, const Color(0xFF8D8E98)),
        ),
        Container(
          child: TextBoxReUsable(currentWeightValue, 50.0, Colors.white),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FloatingActionButton.small(
              heroTag: 'ss',
              backgroundColor: const Color(0xFF4C4F5E),
              onPressed: () {
                updateWeight('Increment');
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
              heroTag: 'ss22',
              backgroundColor: const Color(0xFF4C4F5E),
              onPressed: () {
                updateWeight(' ');
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
}

class AgeWidget extends StatefulWidget {
  const AgeWidget({super.key});

  @override
  State<AgeWidget> createState() => _AgeWidgetState();
}

class _AgeWidgetState extends State<AgeWidget> {
  SliderCurrentValue SliderValue = SliderCurrentValue();
  @override
  Widget build(BuildContext context) {
    String currentAgeValue = SliderValue.getCurrentAgeValue().toString();
    updateWeight(String type) {
      if (type == 'Increment') {
        SliderValue.incrementAge();
      } else {
        SliderValue.decrementAge();
      }
      setState(() {
        currentAgeValue = SliderValue.getCurrentAgeValue().toString();
      });
    }

    TextBoxReUsable(String text, double fontSize, Color fontColor) {
      return Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: fontColor,
        ),
      );
    }

    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 20.0),
          child: TextBoxReUsable('Age', 18.0, const Color(0xFF8D8E98)),
        ),
        Container(
          child: TextBoxReUsable(currentAgeValue, 50.0, Colors.white),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FloatingActionButton.small(
              heroTag: 'ss1',
              backgroundColor: const Color(0xFF4C4F5E),
              onPressed: () {
                updateWeight('Increment');
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
              heroTag: 'ss2',
              backgroundColor: const Color(0xFF4C4F5E),
              onPressed: () {
                updateWeight(' ');
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
}
