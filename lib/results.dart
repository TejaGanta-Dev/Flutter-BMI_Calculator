class BMICAL {
  int currentSliderValue = 0;
  int currentWeightValue = 0;
  BMICAL({required height,required weight}) {
    currentSliderValue = height;
    currentWeightValue = weight;
  }

  getBMI() {
  print('${this.currentSliderValue}');
    final double height = this.currentSliderValue / 100;
    final double bmi = this.currentWeightValue / (height * height);
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
}
