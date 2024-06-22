// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';

class CustomFormDisplay extends StatefulWidget {
  final Map<String, dynamic> formData;

  const CustomFormDisplay({Key? key, required this.formData}) : super(key: key);

  @override
  State<CustomFormDisplay> createState() => _CustomFormDisplayState();
}

class _CustomFormDisplayState extends State<CustomFormDisplay> {
  late TextEditingController titleController;
  late TextEditingController descrController;
  late List<Map<String, dynamic>> questions;
  Map<int, String> selectedRadioValues = {};
  Map<int, List<String>> selectedCheckboxValues = {};

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.formData['title'] as String);
    descrController = TextEditingController(text: widget.formData['descr'] as String);
    questions = List<Map<String, dynamic>>.from(widget.formData['ques'] as List<dynamic>);
  }

  @override
  void dispose() {
    titleController.dispose();
    descrController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Display'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 80, left: 5, right: 5),
          child: Column(
            children: [
              Card(
                elevation: 10,
                surfaceTintColor: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: titleController,
                        readOnly: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: 'Form Title',
                        ),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: descrController,
                        readOnly: true,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: 'Form Description',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ...questions.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> question = entry.value;
                return Card(
                  surfaceTintColor: Colors.white,
                  key: Key('question_$index'),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            question['question'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        buildField(index, question),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildField(int questionIndex, Map<String, dynamic> question) {
    switch (question['type']) {
      case 'Text':
        return TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            hintText: question['question'],
          ),
        );
      case 'Dropdown':
        List<String> options = question['options'].split(',');
        return DropdownButtonFormField<String>(
          items: options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {},
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Select an option',
          ),
        );
      case 'Radio':
        List<String> options = question['options'].split(',');
        return Column(
          children: options.map((option) {
            return RadioListTile<String>(
              title: Text(option),
              value: option,
              groupValue: selectedRadioValues[questionIndex],
              onChanged: (String? value) {
                setState(() {
                  selectedRadioValues[questionIndex] = value!;
                });
              },
            );
          }).toList(),
        );
      case 'Checkbox':
        List<String> options = question['options'].split(',');
        return Column(
          children: options.map((option) {
            return CheckboxListTile(
              title: Text(option),
              value: selectedCheckboxValues[questionIndex]?.contains(option) ?? false,
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    selectedCheckboxValues.putIfAbsent(questionIndex, () => []).add(option);
                  } else {
                    selectedCheckboxValues[questionIndex]?.remove(option);
                  }
                });
              },
            );
          }).toList(),
        );
      default:
        return Container();
    }
  }
}
