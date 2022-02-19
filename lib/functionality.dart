import 'package:flutter/material.dart';
import 'dart:math';

List<int> generateSequence(int length) {
  Random random = Random();
  List<int> numbers = [];

  int prevNum = -1;
  for (int i = 0; numbers.length < length; i++) {
    int randomNumber = random.nextInt(8);

    if (randomNumber != prevNum) {
      numbers.add(randomNumber);
    }
    prevNum = randomNumber;
  }
  return numbers;
}
