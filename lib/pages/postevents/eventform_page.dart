import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gcet_app/db/user_dao.dart';
import 'package:http/http.dart' as http;

class EventFormPage extends StatefulWidget {
  final int eventId;
  final String title;

  EventFormPage({required this.eventId, required this.title});

  @override
  _EventFormPageState createState() => _EventFormPageState();
}

class _EventFormPageState extends State<EventFormPage> {
  List<dynamic> formFields = [];
  late String title;
  String usr = "admin";
  Map<String, dynamic> formData = {}; // To store form data

  @override
  void initState() {
    super.initState();
    title = widget.title;
    _fetchForm();
  }

  Future<void> _submitForm() async {
    String token = await UserDao().getPersistToken(0);
    final url = Uri.parse('http://localhost:3000/api/events/form');
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
        },
        body: jsonEncode({
          'event_id': widget.eventId,
          'responses': formData.entries.map((entry) {
            return {
              'qno': formFields
                  .firstWhere((field) => field['ques'] == entry.key)['qno'],
              'resp': entry.value is List
                  ? entry.value.join(',')
                  : entry.value // Handle checkbox arrays
            };
          }).toList(),
        }));

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Form submitted successfully!'),
          backgroundColor: Colors.green));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to submit form!'),
          backgroundColor: Colors.red));
    }
  }

  Future<void> _fetchForm() async {
    String token = await UserDao().getPersistToken(0);
    final response = await http.get(
        Uri.parse('http://localhost:3000/api/events/form/${widget.eventId}'),
        headers: {
        'Authorization': 'Bearer $token',
      },);
    if (response.statusCode == 200) {
      setState(() {
        formFields = json.decode(response.body).asMap().entries.map((entry) {
          int qno = entry.key + 1;
          var field = entry.value;
          List<String> options = List<String>.from(field['opts'] ?? []);
          return {
            'qno': qno,
            'ques': field['ques'],
            'type': field['type'],
            'opts': options
          };
        }).toList();
      });
    } else {
      // Handle error
      print('Failed to load form');
      Navigator.pop(context);
      
    }
  }

  Widget _buildFormField(Map<String, dynamic> field) {
    int qno = field['qno'];
    String question = field['ques'];
    String type = field['type'];
    List<String> options = field['opts'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$qno. $question', // This handles displaying the question
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        _buildInputField(type, question, options),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget _buildInputField(String type, String question, List<String> options) {
    switch (type) {
      case 'Radio':
        return _buildRadioField(question, options);
      case 'Checkbox':
        return _buildCheckboxField(question, options);
      case 'Dropdown':
        return _buildDropdownField(question, options);
      default:
        return _buildTextField(question);
    }
  }

  Widget _buildRadioField(String question, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: options
          .map((option) => RadioListTile(
                title: Text(option),
                value: option,
                groupValue: formData[question], // Manage selected value
                onChanged: (value) {
                  setState(() {
                    formData[question] = value;
                  });
                },
              ))
          .toList(),
    );
  }

  Widget _buildCheckboxField(String question, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: options
          .map((option) => CheckboxListTile(
                controlAffinity:
                    ListTileControlAffinity.leading, // Checkbox before text
                title: Text(option),
                value: formData[question]?.contains(option) ?? false,
                onChanged: (checked) {
                  setState(() {
                    if (checked == true) {
                      formData.putIfAbsent(question, () => []).add(option);
                    } else {
                      formData[question]?.remove(option);
                    }
                  });
                },
              ))
          .toList(),
    );
  }

  Widget _buildDropdownField(String question, List<String> options) {
    return DropdownButton<String>(
      value: formData[question],
      hint: Text("Select an option"),
      items: options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          formData[question] = newValue;
        });
      },
    );
  }

  Widget _buildTextField(String question) {
    return TextField(
      decoration: InputDecoration(hintText: 'Enter your response'),
      onChanged: (value) {
        setState(() {
          formData[question] = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('$title Registration Form'),
        ),
        body: Stack(children: [
          SingleChildScrollView(
              child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 80, left: 5, right: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...formFields.map((field) {
                            return Card(
                              elevation: 10,
                              surfaceTintColor: Colors.white,
                              key: Key('question_${field['qno']}'),
                              child: Container(
                                padding: EdgeInsets.all(20.0),
                                child: _buildFormField(field),
                              ),
                            );
                          }).toList(),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: _submitForm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(78, 24, 217, 1),
                              ),
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1)),
                              ),
                            ),
                          )
                        ]),
                  )))
        ]));
  }
}
