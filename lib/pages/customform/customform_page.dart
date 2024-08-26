import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcet_app/models/customform_ques.dart';
import 'package:gcet_app/pages/customform/bloc/customform_bloc.dart';
import 'package:gcet_app/pages/postevents/custom_form_display.dart';

class CustomFormPage extends StatefulWidget {
  final List<Question> questions;

  const CustomFormPage({Key? key, required this.questions}) : super(key: key);

  @override
  State<CustomFormPage> createState() => CustomFormPageState();
}

class CustomFormPageState extends State<CustomFormPage> {
  late final TextEditingController titleController;
  late final TextEditingController descrController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descrController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    descrController.dispose();
    super.dispose();
  }

  void submitForm() {
    final state = context.read<CustomFormBloc>().state;
    if (state is CustomFormLoaded) {
      Map<String, dynamic> formData = {
        'title': titleController.text,
        'descr': descrController.text,
        'ques': state.questions,
      };
      Navigator.pop(context, state.questions);
    }
  }

  void previewForm() {
    final state = context.read<CustomFormBloc>().state;
    if (state is CustomFormLoaded) {
      List<Map<String, dynamic>> questionsJson =
          state.questions.map((q) => q.toJson()).toList();
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
  }

  Widget buildFieldOptions(BuildContext context, question, int questionIndex) {
    print("hello");
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
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () => context
                      .read<CustomFormBloc>()
                      .add(RemoveFieldOptionEvent(questionIndex, index)),
                ),
              ],
            );
          }).toList(),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              context
                  .read<CustomFormBloc>()
                  .add(AddFieldOptionEvent(questionIndex));
              print(question.fieldControllers);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(78, 24, 217, 1),
            ),
            child: Text(
              "Add Radio Button",
              style: TextStyle(color: Colors.white),
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
                        hintText: 'Option ${index + 1}',
                      ),
                    ),
                    value: false,
                    onChanged: (value) {
                      setState(() {
                        // Handle checkbox change
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () => context
                      .read<CustomFormBloc>()
                      .add(RemoveFieldOptionEvent(questionIndex, index)),
                ),
              ],
            );
          }).toList(),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => context
                .read<CustomFormBloc>()
                .add(AddFieldOptionEvent(questionIndex)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(78, 24, 217, 1),
            ),
            child: Text(
              "Add Checkbox Option",
              style: TextStyle(color: Colors.white),
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
                        hintText: 'Option ${index + 1}',
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () => context
                      .read<CustomFormBloc>()
                      .add(RemoveFieldOptionEvent(questionIndex, index)),
                ),
              ],
            );
          }).toList(),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => context
                .read<CustomFormBloc>()
                .add(AddFieldOptionEvent(questionIndex)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(78, 24, 217, 1),
            ),
            child: Text(
              "Add Dropdown Option",
              style: TextStyle(color: Colors.white),
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
            child: BlocConsumer<CustomFormBloc, CustomFormState>(
              listener: (BuildContext context, CustomFormState state) {},
              builder: (context, state) {
                if (state is CustomFormLoaded) {
                  print("hello state");
                  return Container(
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
                        ...state.questions.asMap().entries.map((entry) {
                          int index = entry.key;
                          print("hello  ques");
                          Question question = entry.value;
                          return Card(
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
                                          controller:
                                              question.questionController,
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
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () => context
                                            .read<CustomFormBloc>()
                                            .add(RemoveQuestionEvent(index)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  DropdownButtonFormField<String>(
                                    value: question.selectedFieldType.isEmpty
                                        ? null
                                        : question.selectedFieldType,
                                    items: [
                                      'Radio',
                                      'Checkbox',
                                      'Dropdown',
                                      'Text'
                                    ]
                                        .map((type) => DropdownMenuItem(
                                              value: type,
                                              child: Text(type),
                                            ))
                                        .toList(),
                                    onChanged: (newValue) {
                                      // Trigger an event to update the field type only for this question.
                                      context.read<CustomFormBloc>().add(
                                            UpdateFieldTypeEvent(
                                                index: index,
                                                newFieldType: newValue!),
                                          );
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintText: 'Select Field Type',
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  buildFieldOptions(context, question, index),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            final newQuestion = Question(
                              questionController: TextEditingController(),
                              selectedFieldType: 'Radio',
                              fieldControllers: [TextEditingController()],
                            );
                            context
                                .read<CustomFormBloc>()
                                .add(AddQuestionEvent(newQuestion));
                          },
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
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Card(
              elevation: 20,
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: previewForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(78, 24, 217, 1),
                        ),
                        child: Text(
                          "Preview Form",
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1)),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(78, 24, 217, 1),
                        ),
                        child: Text(
                          "Submit Form",
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
