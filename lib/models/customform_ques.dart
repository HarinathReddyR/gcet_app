import 'package:flutter/material.dart';

class Question {
  TextEditingController questionController;
  String selectedFieldType;
  List<TextEditingController> fieldControllers;

  Question({
    required this.questionController,
    required this.selectedFieldType,
    required this.fieldControllers,
  });
  

  Map<String, dynamic> toJson() {
    return {
      'question': questionController.text,
      'type': selectedFieldType,
      'options':
          fieldControllers.map((controller) => controller.text).toList(),
    };
  }
}
