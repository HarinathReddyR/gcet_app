// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gcet_app/db/user_dao.dart';
import 'package:gcet_app/models/customform_ques.dart';
import 'package:gcet_app/pages/postevents/custom_form_display.dart';

// class Question {
//   TextEditingController questionController;
//   String selectedFieldType;
//   List<TextEditingController> fieldControllers;

//   Question({
//     required this.questionController,
//     required this.selectedFieldType,
//     required this.fieldControllers,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'question': questionController.text,
//       'type': selectedFieldType,
//       'options':
//           fieldControllers.map((controller) => controller.text).join(','),
//     };
//   }
// }

class CustomFormPage extends StatefulWidget {
  final List<Question> questions;
  final String title, desc;
  const CustomFormPage({
    Key? key,
    required this.title,
    required this.desc,
    required this.questions,
  }) : super(key: key);

  @override
  State<CustomFormPage> createState() => CustomFormPageState();
}

class CustomFormPageState extends State<CustomFormPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descrController = TextEditingController();
  late List<Question> questions;
  List<String> formFields = <String>['Radio', 'Dropdown', 'Text', 'Checkbox'];

  @override
  void initState()  {
    super.initState();
    titleController.text = widget.title;
    descrController.text = widget.desc;
    questions = widget.questions;
  }

  void submitForm() {
    // List<Map<String, dynamic>> questionsJson =
    //     questions.map((q) => q.toJson()).toList();
    // Map<String, dynamic> formData = {
    //   'title': titleController.text,
    //   'descr': descrController.text,
    //   'ques': questions,
    // };
    Navigator.pop(context, questions);
  }

  void addNewQuestion() {
    setState(() {
      questions.add(
        Question(
          questionController: TextEditingController(),
          selectedFieldType: formFields[0],
          fieldControllers: [TextEditingController()],
        ),
      );
    });
  }

  void addFieldOption(Question question) {
    setState(() {
      question.fieldControllers.add(TextEditingController());
    });
  }

  void removeFieldOption(Question question, int index) {
    setState(() {
      question.fieldControllers[index].dispose();
      question.fieldControllers.removeAt(index);
    });
  }

  void removeQuestion(int index) {
    setState(() {
      questions[index].questionController.dispose();
      for (var controller in questions[index].fieldControllers) {
        controller.dispose();
      }
      questions.removeAt(index);
    });
  }

  Widget deleteOption(Question question, int index) {
    return IconButton(
      icon: Icon(Icons.clear),
      onPressed: () => removeFieldOption(question, index),
    );
  }

  Widget deleteQuestionIcon(int index) {
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: () => removeQuestion(index),
    );
  }

  void previewForm() {
    List<Map<String, dynamic>> questionsJson =
        questions.map((question) => question.toJson()).toList();

    Map<String, dynamic> formData = {
      'title': titleController.text,
      'descr': descrController.text,
      'ques': questionsJson,
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomFormDisplay(formData: formData),
      ),
    );
  }

  Widget buildFieldOptions(Question question) {
    if (question.selectedFieldType == 'Radio') {
      return Column(
        children: [
          ...question.fieldControllers.asMap().entries.map((entry) {
            int index = entry.key;
            TextEditingController controller = entry.value;
            return Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    title: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: 'Option ${index + 1}',
                      ),
                    ),
                    value: index,
                    groupValue: 0,
                    onChanged: (value) {
                      setState(() {
                        // Handle radio button change
                      });
                    },
                  ),
                ),
                deleteOption(question, index),
              ],
            );
          }).toList(),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => addFieldOption(question),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(78, 24, 217, 1),
            ),
            child: Text(
              "Add Radio Button",
              style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
            ),
          ),
        ],
      );
    } else if (question.selectedFieldType == 'Checkbox') {
      return Column(
        children: [
          ...question.fieldControllers.asMap().entries.map((entry) {
            int index = entry.key;
            TextEditingController controller = entry.value;
            return Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: 'Option',
                      ),
                    ),
                    value:
                        false, // Placeholder value, should be managed properly
                    onChanged: (value) {
                      setState(() {
                        // Handle change
                      });
                    },
                  ),
                ),
                deleteOption(question, index),
              ],
            );
          }).toList(),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => addFieldOption(question),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(78, 24, 217, 1),
            ),
            child: Text(
              "Add Checkbox Option",
              style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
            ),
          ),
        ],
      );
    } else if (question.selectedFieldType == 'Dropdown') {
      return Column(
        children: [
          ...question.fieldControllers.asMap().entries.map((entry) {
            int index = entry.key;
            TextEditingController controller = entry.value;
            return Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: 'Option',
                      ),
                      onChanged: (value) {
                        setState(() {
                          // Handle change
                        });
                      },
                    ),
                  ),
                ),
                deleteOption(question, index),
              ],
            );
          }).toList(),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => addFieldOption(question),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(78, 24, 217, 1),
            ),
            child: Text(
              "Add Dropdown Option",
              style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
            ),
          ),
        ],
      );
    } else if (question.selectedFieldType == 'Text') {
      return TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide.none),
          hintText: 'Enter text',
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate your form'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
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
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
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
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
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
                    Question question = entry.value;
                    return Card(
                      // borderOnForeground:false,
                      elevation: 10,
                      surfaceTintColor: Colors.white,
                      key: Key('question_$index'),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: question.questionController,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintText: 'Enter your Question',
                                    ),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                deleteQuestionIcon(index),
                              ],
                            ),
                            SizedBox(height: 10),
                            DropdownButton<String>(
                              value: question.selectedFieldType,
                              onChanged: (String? newValue) {
                                setState(() {
                                  question.selectedFieldType = newValue!;
                                });
                              },
                              items: formFields.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 10),
                            buildFieldOptions(question),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: addNewQuestion,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(78, 24, 217, 1),
                          ),
                          child: Text(
                            "Add Question",
                            style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(13),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    onPressed: () => previewForm(),
                  ),
                  ElevatedButton(
                    onPressed: submitForm,
                    // onPressed: () => Navigator.push(
                    //                   context,
                    //                   MaterialPageRoute(
                    //                       builder: (context) => CustomFormDisplay()),
                    //                 ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(78, 24, 217, 1),
                    ),
                    child: Text(
                      "Submit Form",
                      style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
